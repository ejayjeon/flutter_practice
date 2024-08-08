
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:miner_skale_proto/service/dbsctl_service.dart';
import 'package:miner_skale_proto/service/web3_service.dart';
import 'package:web3dart/web3dart.dart';

part 'mining_service_config.dart';

class MiningService {

  static final MiningService _miningService = MiningService._();
  factory MiningService () {
    return _miningService;
  }

  MiningService._();

  final _dbsctlService = DbsctlService();
  final _web3service = Web3Service();

  final _receivePort = ReceivePort();

  // API
  Future<void> startMiningFreeGas(String addr) async {

    print('Ready to run _performFreeGasMining in task module');

    // 1. compare freeGass from local DB with blocchain nonce
    // from db
    var lastNonceMined = await _dbsctlService.lastNonceMined(addr);
    if(lastNonceMined < 0) {
      //error state
      // for dev only.
      // we assume Zero
      lastNonceMined = 0;
    }

    final currentNonce = await _web3service.getTransactionCount(EthereumAddress.fromHex(addr));

    // 2. validate nonce requirement
    // 예제: 최소 리저브: 30개
    // for productiion. set this value higher, like 30.
    const maxReserve = 3;

    var starterNonce = 0;
    var numberOfGasReserveToMine = 0;

    if(currentNonce > lastNonceMined) {
      // wallet addr maybe imported one, or
      // app was installed anew
      starterNonce = currentNonce;
      numberOfGasReserveToMine = maxReserve;

    } else {

      starterNonce = lastNonceMined + 1;
     
      // short-circuit this if-else
      int floor = lastNonceMined - currentNonce;
      if(floor >= maxReserve) {
        // no need to mine
        numberOfGasReserveToMine = 0;

      } else {
        numberOfGasReserveToMine = maxReserve - floor;
      }
    }

    // 3. final check
    if(0 == numberOfGasReserveToMine) {
      // no need to mine.
      print("there's enuff free gas in reserve");

    } else {

      var rootToken = RootIsolateToken.instance;
      await Isolate.spawn<_MiningServiceData>(
        _runnablePoWTask,
        _MiningServiceData(
          token: rootToken!, 
          sendPort: _receivePort.sendPort,
          dbsctlService: _dbsctlService,
          addr: addr,
          startingNonce: starterNonce,
          miningCount: numberOfGasReserveToMine
        )
      );

    _receivePort.listen((message) {
      if(0 == message) {
        print('Finished mining free gas reserves');
      }
    });
  }
 }

  // call this after TX is successfully commited
  Future<int> writeOffUsedFreeGas(String addr, int nonce, String txReceipt) async {

    final rs = await _dbsctlService.addTxHash(addr, nonce, txReceipt);
    return Future.value(rs);
  }

  Future<String?> getSavedFreeGas(String addr, int nonce) async {

    final rs = await _dbsctlService.getPowHash(addr, nonce);

    final iter = rs?.firstOrNull;
    final elem = iter?['powHash'];

    if(null == elem) {
      return Future.value();
    }

    return Future.value(elem as String);
  }


  static void _runnablePoWTask(_MiningServiceData miningServiceData) async {
    
    BackgroundIsolateBinaryMessenger.ensureInitialized(miningServiceData.token);
    Web3Service web3service = Web3Service();

    SendPort sendPort = miningServiceData.sendPort;
    String addr = miningServiceData.addr;
    int starterNonce = miningServiceData.startingNonce;
    int numberOfGasReserveToMine = miningServiceData.miningCount;
    DbsctlService dbsctlService = miningServiceData.dbsctlService;

    final limit = starterNonce + numberOfGasReserveToMine;
  
    // keep reference for validation
    List<BigInt> hashes = [];
    List<int> dbInsertResults = [];

    for(var iter = starterNonce; iter < limit; ++iter) {

      final stopwatch = Stopwatch();
      stopwatch.start();
        final powHash = await web3service.mineFreeGas(120000, EthereumAddress.fromHex(addr), iter, null);
      stopwatch.stop();
        hashes.add(powHash);

      final rzInsert = await dbsctlService.addPoWHash(iter, addr, powHash, stopwatch.elapsed.toString());

      dbInsertResults.add(rzInsert);
    }

    // ToDo: do validation using hashes[], dbInsertResults[]

    // done
    sendPort.send(0);
  }


}