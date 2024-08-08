import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miner_skale_proto/actions/cmds_actions.dart';
import 'package:miner_skale_proto/actions/displayable.dart';
import 'package:miner_skale_proto/actions/info_actions.dart';
import 'package:miner_skale_proto/actions/mode_actions.dart';
import 'package:miner_skale_proto/actions/actionables.dart';
import 'package:miner_skale_proto/app/app_proxy.dart';
import 'package:miner_skale_proto/app/app_top.dart';
import 'package:miner_skale_proto/service/dbsctl_service.dart';
import 'package:miner_skale_proto/service/mining_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


void main() {

  // sqfliteFfiInit();
  // databaseFactory = databaseFactoryFfi;

  runApp(const MyApp());

  // init
  final dbsctl = DbsctlService();

  dbsctl.load()
  .then((value) {
    print('dbsctl.load: $value');
    _runDevCheck(dbsctl);
  })
  .catchError( (e) {
    print(e);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Miner Skale Proto',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<ModeAction>(create: (context) => ModeAction(initState: Actionables.manualTest)),
          BlocProvider<CmdsAction>(create: (context) => CmdsAction(initState: Actionables.undefined)),
          BlocProvider<InfoAction>(create: (context) => InfoAction(initState: Displayable.appReady))
        ],
        child: AppProxy()
      )
    );
  }
}


void _runDevCheck(DbsctlService dbsctlService) async {

    // simple checkup
    const testAddr = '0x4E66020BE5388F76F51F0C4C10219a9c4B8979fE';
    final value = await dbsctlService.getPoWHashResreveCounts(testAddr);
      print('runDevSetup.getPowHasReserveCount: $value');
    

    final miningService = MiningService();
    final powHash = await miningService.getSavedFreeGas(testAddr, 5);
      print('getSavedGas: $powHash');

    final didWriteOff = await miningService.writeOffUsedFreeGas(testAddr, 5, 'fake-tx-receipt');
      print('writeOffusedFreeGas: $didWriteOff');
    
    dbsctlService.lastNonceMined(testAddr)
      .then((value) => print(value));
}