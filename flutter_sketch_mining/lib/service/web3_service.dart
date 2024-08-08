/// @author M.K. Kim
import 'dart:io';
import 'package:eth_sig_util/util/abi.dart';
import 'package:miner_skale_proto/externs/shared.dart';
import 'package:miner_skale_proto/helpers/DecimalHelper.dart';
import 'package:miner_skale_proto/mixins/logger_mixin.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:async';
import 'dart:convert';
import 'package:decimal/decimal.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import 'package:xor_encryption/xor_encryption.dart';
import 'package:xor_cipher/xor_cipher.dart';
import 'dart:math';

part 'web3_service_config.dart';

class Web3Service with LoggerMixin {

  bool initialized = false;
  static final _web3serviceConfig = _Web3ServiceConfig();
  Web3Client _web3client;


  static final Web3Service _web3service = Web3Service._();

  factory Web3Service () {
    return _web3service;
  }

  Web3Service._()  : 
    _web3client = Web3Client(
    _web3serviceConfig.rpc,
    Client(),
    socketConnector: () {
      return IOWebSocketChannel.connect(_web3serviceConfig.wss).cast<String>();
    }
  );

 Future<BigInt> mineFreeGas(
  int gasAmount,
  EthereumAddress from,
  int nonce,
  Uint8List? bytes
 ) async {

  logger.i('Mining free gas for nonce: $nonce');

  final gasAmountInt = gasAmount.toInt();
  final nonceHash = bytesToInt(AbiUtil.soliditySHA3(["uint256"], [nonce]));
  final addressHash = bytesToInt(AbiUtil.soliditySHA3(["address"], [from.addressBytes]));

  final nonceAddressXOR = nonceHash ^ addressHash;
  final maxNumber = getMaxNumber();
  final divConstant = BigInt.from(maxNumber / BigInt.one);

  BigInt candiate;
  int iteration = 0;

  while(true)  {
    candiate = bytesToInt(padUint8ListTo32(bytes ?? randomBytes(32, secure: true)));

    BigInt candidateHash = bytesToInt(AbiUtil.soliditySHA3(["uint256"], [candiate]));
    BigInt resultHash = nonceAddressXOR ^ candidateHash;

    double externalGas = divConstant / resultHash;

    if(externalGas >= gasAmountInt) {
      if(candiate.isNegative) {
        logger.w('gasMined but is invalid: $externalGas');
        logger.i(candiate);
      } else {
        logger.w('externalGas mined: $externalGas');
        break;
      }
      
    }

    if(iteration++ % 100000 == 0) {
      await Future.delayed(Duration.zero);
      print(iteration);
    }
    ++iteration;
  }
    
  logger.i('Iteration count: $iteration');

  return candiate;
 }

Future<String> sendTxWithFreeGas(String pkey, BigInt minedGas, {String? contractAddr}) async {

    // sender alias: rnd-gen-5
    String sender = '0x4E66020BE5388F76F51F0C4C10219a9c4B8979fE';
    final ethBase = EthereumAddress.fromHex("0x0000000000000000000000000000000000000000");
    EthPrivateKey creds = EthPrivateKey.fromHex(pkey);
    final from = creds.address;
    

    final nonce = await _web3client?.getTransactionCount(from);
    BigInt gasAmount = BigInt.from(100000);

    final tx = await _devCreateTx(
      senderAddr: sender,
      gasPrice: minedGas,
      gasAmount: gasAmount
    
    );
    final signedTx = await _devCrtSignedTx(
      tx, 
      pkey: pkey
    );

    final txHash = await _web3client.sendRawTransaction(signedTx);
    final txRict = await _web3client
      .addedBlocks()
      .asyncMap((_) => _web3client.getTransactionReceipt(txHash))
      .where((receipt) => receipt != null)
      .first;

    logger.i('txHash: $txHash');
    logger.i('txRict: $txRict');

    return txRict.toString();
  }


 Future<String> devSendFreeTx(String pkey, {String? contractAddr}) async {

    // sender alias: rnd-gen-5
    // String sender = '0x4E66020BE5388F76F51F0C4C10219a9c4B8979fE';
    final ethBase = EthereumAddress.fromHex("0x0000000000000000000000000000000000000000");
    EthPrivateKey creds = EthPrivateKey.fromHex(pkey);
    final from = creds.address;
    

    final nonce = await _web3client.getTransactionCount(from);
    const gasAmount = 100000;
    
    final minedGas = await mineFreeGas(gasAmount, from, nonce, null);
    // final freeGas = prepPoWGas(fixedGasPrice, sender.toString(), BigInt.from(nonce));
    logger.w('minedGas: $minedGas');

    final tx = await _devCreateTx(gasPrice: minedGas);
    final signedTx = await _devCrtSignedTx(tx, pkey: pkey);

    final txHash = await _web3client.sendRawTransaction(signedTx);
    final txRict = await _web3client
      .addedBlocks()
      .asyncMap((_) => _web3client.getTransactionReceipt(txHash))
      .where((receipt) => receipt != null)
      .first;

    logger.i('txHash: $txHash');
    logger.i('txRict: $txRict');

    return txRict.toString();
  }

  BigInt prepPoWGas(
    BigInt gasAmount,
    String addr,
    BigInt nonce
  ) {

    final nonceHashStr = const Utf8Decoder().convert(keccak256(_bigintToUint8List(nonce)));
    final nonceHash = BigInt.parse(nonceHashStr);

    final addrHashStr = const Utf8Decoder().convert(keccak256(_stringToUint8List(addr)));
    final addrHash = BigInt.parse(addrHashStr);

    // final nonceAddrXor = XOR.encrypt(nonceHash, addrHash);
    final nonceAddrXor = nonceHash ^ addrHash;

    final maxNumber = double.maxFinite.toInt() - 1;
    final maxInt = BigInt.from(maxNumber);
    final divConst = BigInt.from(maxInt / BigInt.one);

    BigInt candiate;
    while(true) {
      candiate = BigInt.parse(_randomHexString());

      final candiateHashStr = const Utf8Decoder().convert(keccak256(_bigintToUint8List(candiate)));
      final candidateHash = BigInt.parse(candiateHashStr);

      // final resultHash = XOR.encrypt(nonceAddrXor, candiateHash);
      final resultHash = nonceAddrXor ^ candidateHash;

      final externGas =  BigInt.from(divConst / resultHash);

      if(externGas >= gasAmount) {
        break;
      }

    }
    return candiate;
  }


  String _randomHexString({int length = 16}) {
    Random random = Random();
    StringBuffer sb = StringBuffer();

    for (var i = 0; i < length; i++) {
      sb.write(random.nextInt(16).toRadixString(16));
    }

    return sb.toString();
  }

  Uint8List _stringToUint8List(String val) {

    List<int> list = utf8.encode(val);
    return Uint8List.fromList(list);
  }

  Uint8List _bigintToUint8List(BigInt val) {
    final rawStr = val.toString();
    List<int> list = utf8.encode(rawStr);
    return Uint8List.fromList(list);
  }

 
  Future<String> devSendBulkTx({String? pkey, String? contractAddr}) async {

    // this 'await' does not guarantee mined block
    final signedTx = await _devCrtSignedTx(await _devCreateTx());
    final txHash = await _web3client.sendRawTransaction(signedTx);
    final txRict = await _web3client
      .addedBlocks()
      .asyncMap((_) => _web3client.getTransactionReceipt(txHash))
      .where((receipt) => receipt != null)
      .first;

    logger.i('txHash: $txHash');
    logger.i('txRict: $txRict');

    return txRict.toString();
  }

  Future<Uint8List> _devCrtSignedTx(Transaction transaction, {String? pkey, String? contractAddr}) async {

    var envFundMgrPkey = _web3serviceConfig.fundMgrPkey;
    var envDltgAddress = _web3serviceConfig.dltgAddress;
    var envChainId     = _web3serviceConfig.chainId;

    pkey ??= envFundMgrPkey;
    contractAddr ??= envDltgAddress;

    final creds = EthPrivateKey.fromHex(pkey);
    return await _web3client.signTransaction(
      creds, 
      transaction,
      chainId: 37084624
    );
  }

  Future<Transaction> _devCreateTx({
    String? senderAddr, 
    String? contractAddr,
    BigInt? gasPrice,
    BigInt? gasAmount
  }) async {

    final envFundMgrAddr = _web3serviceConfig.fundMgrAddr;
    final envDltgAddress = _web3serviceConfig.dltgAddress;

    senderAddr ??= envFundMgrAddr;
    contractAddr ??= envDltgAddress;

    final fundMgrAddr = EthereumAddress.fromHex(senderAddr, enforceEip55: true);
    final dltgAddress = EthereumAddress.fromHex(envDltgAddress, enforceEip55: true);

    // 첵섬 주소 무시
    // we do this to make sure web3 lib is cross-platform compatible
    // assert(0 == fundMgrAddr.compareTo(EthereumAddress.fromHex(envFundMgrAddr)));

    // get nonce first
    var nonce = await _web3client.getTransactionCount(fundMgrAddr);

    // create args data
    // List<FunctionParameter> paramSigs = [
    //   const FunctionParameter("recipients", DynamicLengthArray(type: AddressType())),
    //   const FunctionParameter("amounts", DynamicLengthArray(type: IntType()))
    // ];
    
    // final funx = ContractFunction(
    //   "transport", 
    //    paramSigs,
    //    outputs: []
    // );

    // we need to conver string addr to EthereumAddress
    List<EthereumAddress> addrs = [];
    for(final iter in _web3serviceConfig.addrs) {
      addrs.add(EthereumAddress.fromHex(iter, enforceEip55: true));
    }

    List<BigInt> amounts = [];
    for(final iter in _web3serviceConfig.amounts) {
      amounts.add(EtherAmount.inWei(etherToWei(iter)).getInWei);
    }
    
    final jsonAbi = jsonEncode(_web3serviceConfig.abi);
    logger.i('jsonAbi: $jsonAbi');

    final contractAbi = ContractAbi.fromJson(jsonAbi, '');
    final contract = DeployedContract(
      contractAbi,
      dltgAddress,
    );

    logger.i('addr[] $addrs');
    logger.i('amounts[] $amounts');
    
    gasPrice ??= BigInt.from(21000);
    logger.w('final gasPrice: $gasPrice');

    gasAmount ??= BigInt.from(100000);
    logger.i('final gasAmount: $gasAmount');

    final fee = await _web3client.estimateGas(
      sender: fundMgrAddr,
      to: dltgAddress,
      amountOfGas: gasAmount,
      gasPrice: EtherAmount.fromBigInt(EtherUnit.wei, gasPrice),
      value: EtherAmount.zero(),
      data: contract.function('transport').encodeCall([addrs, amounts])
    );

    return 
      Transaction(
          to: dltgAddress,
          gasPrice: EtherAmount.inWei(gasPrice),
          maxGas: fee.toInt(),
          value: EtherAmount.zero(),
          nonce: nonce,
          data: contract.function('transport').encodeCall([addrs, amounts])
      );
  }

  BigInt etherToWei(dynamic ether) {
    if (ether is! Decimal) {
      ether = DecimalHelper.encode(ether); // NOTE : 데시멀 검수 통과
    }

    // ORIGIN
    // // print('ether $ether');
    // final dEther = Decimal.parse(ether.toString());

    // print('_dEther $_dEther');
    final Decimal decimal = ether * Decimal.fromInt(1000000000000000000);
    // print('_decimal $_decimal');
    return BigInt.parse(decimal.toString());
  }


  Future<int> getTransactionCount(EthereumAddress addr) async {
    return await _web3client.getTransactionCount(addr);
  }
}