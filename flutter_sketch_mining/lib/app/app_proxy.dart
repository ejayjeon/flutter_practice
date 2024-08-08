
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miner_skale_proto/actions/cmds_actions.dart';
import 'package:miner_skale_proto/actions/mode_actions.dart';
import 'package:miner_skale_proto/app/app_bot.dart';
import 'package:miner_skale_proto/app/app_mid.dart';
import 'package:miner_skale_proto/app/app_sts.dart';
import 'package:miner_skale_proto/app/app_top.dart';

class AppProxy extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final bgColor = context.read<CmdsAction>().isMiningInProgress
      ? Colors.blueAccent.shade400 : Colors.indigo.shade200;
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column( 
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex:1,
                child: AppSts()
              ),
              Expanded(
                flex:4,
                child: AppTop()
              ),

              Expanded(
                flex: 6,
                child: AppMid()
              ),
              Expanded(
                flex:1,
                child: AppBot()
              ),
            ],
          )
        )
      )
    );
  }
}