import 'dart:convert';
import 'dart:io';

import 'package:bloc/src/change.dart';
import 'package:flutter/material.dart';
import 'package:miner_skale_proto/actions/actionables.dart';
import 'package:miner_skale_proto/actions/basic_cubit.dart';
import 'package:miner_skale_proto/mixins/logger_mixin.dart';
import 'package:miner_skale_proto/service/dbsctl_service.dart';
import 'package:miner_skale_proto/service/mining_service.dart';
import 'package:miner_skale_proto/service/web3_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:web3dart/web3dart.dart';

class CmdsAction extends BasicCubit with LoggerMixin {
  CmdsAction({Actionables? initState}) : super(initState: initState);

  final _web3service = Web3Service();
  final _dbsctlService = DbsctlService();
  final _miningService = MiningService();


  /// 0 not started
  /// 90  success
  /// negative error
  bool _isMingingInProgress = false;
  bool get isMiningInProgress => _isMingingInProgress;

  String _msg = 'Undefined action';
  String get msg => _msg; 


  @override
  void onPressed(Actionables userAction) {
    super.onPressed(userAction);

    switch(userAction) {
      case Actionables.devShowStats: {
              
        _showStats(_web3service, _dbsctlService);
        emit(Actionables.devUpdate);

        break;
      }
      default: {

      }
    }
  }

  @override
  void onChange(Change<Actionables> change) {
    super.onChange(change);

    logger.i('onChange: $change');

    switch(change.nextState) {
      case Actionables.startMiningReserves: {

        _msg = 'startMiningReserves() called';

        // rng-gen-5
        const testAddr = '0x4E66020BE5388F76F51F0C4C10219a9c4B8979fE';
        _miningService.startMiningFreeGas(testAddr)
          .then((value) {
            _msg = 'startMiningReserves() done';
            print(_msg);
          })
          .catchError((e) => print(e));
        break;
      }

      case Actionables.mineFreeGasInit: {

        emit(Actionables.mineFreeGasProc);
        _mineFreeGas(_web3service);
        emit(Actionables.mineFreeGasCpl);

        break;
      }
      case Actionables.sendTxWithoutSFuel: {

        _msg = 'Sending TX without sFuel...';
        _sendWithoutSFuel(
          _web3service,
          _dbsctlService,
          _miningService
        );
        break;
      }

      case Actionables.createSignedBulkTx: {

        _msg = 'Mining free gas is in progress...';
        emit(Actionables.mineFreeGasProc);

        break;
      }
      case Actionables.mineFreeGasProc: {
        _msg = 'Mining free gas is in progress...';
        print('miningfreeGasProc');

          // simualte minging time
          // Future.delayed(const Duration(seconds: 5));
          sleep(const Duration(seconds: 4));

        emit(Actionables.mineFreeGasCpl);
        break;
      }
      case Actionables.mineFreeGasCpl: {

        _msg = 'Mining free gas complete';
        print('miningfreeGasCpl');

        emit(Actionables.devUpdate);
        break;
      }
      case Actionables.mineAndSendFreeTx: {
        _mineAndSendFreeTx(_web3service);
        break;
      }
      default: {
        // fall thru
      }
    }
  }

  ///
  /// This is the main User-action
  /// 
  Future<void> _sendWithoutSFuel(
    Web3Service web3service,
    DbsctlService dbsctlService,
    MiningService miningService
  ) async {
    


  }

  ///
  /// This is a on-the-go TX which does not use free gas saved in the DB
  /// 
  Future<void> _mineAndSendFreeTx(Web3Service web3service) async {
    // alias rnd-gen-5
    // final sender = EthereumAddress.fromHex('0x4E66020BE5388F76F51F0C4C10219a9c4B8979fE');
    final EthPrivateKey creds = EthPrivateKey.fromHex('0xe435881e0df7db04dc90bc1c39227abeb29f5cc43bd52d7b62e7c03d2987c77c');
    final from = creds.address;

    final nonce = await web3service.getTransactionCount(from);
    const gasAmount = 150000;

    BigInt minedGas = await web3service.mineFreeGas(gasAmount, from, nonce, null);
    logger.w('FreeHash: $minedGas');

    await _sendFreeTx(web3service, minedGas);
  }

  //
  Future<BigInt> _mineFreeGas(Web3Service web3service) async {

    _isMingingInProgress = true;

    // alias rnd-gen-5
    // final sender = EthereumAddress.fromHex('0x4E66020BE5388F76F51F0C4C10219a9c4B8979fE');
    final EthPrivateKey creds = EthPrivateKey.fromHex('0xe435881e0df7db04dc90bc1c39227abeb29f5cc43bd52d7b62e7c03d2987c77c');
    final from = creds.address;

    final nonce = await web3service.getTransactionCount(from);
    const gasAmount = 100000;

    // ToDo: remove stopwatch in production
    final stopwatch = Stopwatch();
    stopwatch.start();
      BigInt powHash = await web3service.mineFreeGas(gasAmount, from, nonce, null);
    stopwatch.stop();

    logger.w('FreeHash: $powHash');
    logger.i('Elasped: ${stopwatch.elapsed}');

    // final rz = await _dbsctlService.addPoWHash(nonce, from.hex, powHash, stopwatch.elapsed.toString());
    // logger.i('addPow.rz: $rz');

    _isMingingInProgress = false;

    return powHash;
  }
  

  Future<void> _sendFreeTx(Web3Service web3service, BigInt minedGas) async {

    // pkey belongs to -
    // rnd-gen-5
    final pkey = '0xe435881e0df7db04dc90bc1c39227abeb29f5cc43bd52d7b62e7c03d2987c77c';
    final rz = await web3service.sendTxWithFreeGas(pkey, minedGas);

    logger.w("Final TX Receipt: $rz");
  }

  Future<void> _showStats(Web3Service web3service, DbsctlService dbsctlService) async {
   
    // simple checkup
    const testAddr = '0x4E66020BE5388F76F51F0C4C10219a9c4B8979fE';
    final rz = await dbsctlService.getPoWHashResreveCounts(testAddr);
      
    final count = Sqflite.firstIntValue(rz);
    
    final lastNoncMined = await dbsctlService.lastNonceMined(testAddr);

    final Map<String, String> stats = {
      'Test Addr: ': testAddr,
      'sFuel Reserves: ': count.toString(),
      'Last Nonce Mined: ': lastNoncMined.toString()
    };

    final encoder = JsonEncoder.withIndent(' ' * 4);
    _msg = encoder.convert(stats);

  }
    
}