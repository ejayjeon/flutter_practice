
import 'package:flutter/material.dart';
import 'package:miner_skale_proto/actions/mode_actions.dart';
import 'package:miner_skale_proto/actions/actionables.dart';
import 'package:miner_skale_proto/mixins/component_builder.dart';

class AppBot extends StatelessWidget with ComponentBuilder<ModeAction> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade800,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: createUserActionButtons(context, {
          'Manual Test': Actionables.manualTest,
          'Auto Test': Actionables.autoTest
        })
      )
    );
  }
}