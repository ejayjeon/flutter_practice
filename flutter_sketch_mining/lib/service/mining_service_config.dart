part of 'mining_service.dart';

class _MiningServiceData {

  final RootIsolateToken token;
  final SendPort sendPort;
  final DbsctlService dbsctlService;
  final String addr;
  final int startingNonce;
  final int miningCount;

  _MiningServiceData({
    required this.token,
    required this.sendPort,
    required this.dbsctlService,
    required this.addr,
    required this.startingNonce,
    required this.miningCount
  });
}