
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miner_skale_proto/actions/actionables.dart';
import 'package:miner_skale_proto/actions/cmds_actions.dart';
import 'package:miner_skale_proto/actions/displayable.dart';
import 'package:miner_skale_proto/actions/info_actions.dart';
import 'package:miner_skale_proto/actions/mode_actions.dart';


class AppTop extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CmdsAction, Actionables>(
      listener: (context, state) {
        // fall thru for now

        print('app_top.onBuild: $state');
      },
      builder: (context, state) {
        // switch on error
        // final updatedState = context.watch<CmdsAction>().state;
        return _makeComponent(context, state);
      }
    );
  }

  Widget _makeComponent(BuildContext context, Actionables state) {


    return
      Container( 
        color: Colors.black,
        padding: const EdgeInsets.all(4.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Text( 
            context.read<CmdsAction>().msg,
            style: TextStyle(
              color: Colors.greenAccent.shade700,
              fontSize: 11
            ),
            ),
          )
      );

  }

}