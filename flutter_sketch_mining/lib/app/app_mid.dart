
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miner_skale_proto/actions/mode_actions.dart';
import 'package:miner_skale_proto/actions/actionables.dart';
import 'package:miner_skale_proto/components/transport_auto.dart';
import 'package:miner_skale_proto/components/transport_manual.dart';

class AppMid extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ModeAction, Actionables>(
        builder: (context, state) {
        return state == Actionables.manualTest ? TransportManual() : TransportAuto();
      },
    );
  }
}