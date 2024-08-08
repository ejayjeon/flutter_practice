
import 'package:flutter/material.dart';
import 'package:miner_skale_proto/actions/cmds_actions.dart';
import 'package:miner_skale_proto/actions/actionables.dart';
import 'package:miner_skale_proto/mixins/component_builder.dart';

class TransportCmds extends StatelessWidget with ComponentBuilder<CmdsAction> {


  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: createUserActionButtons(context, {
        'SendTxWithoutSFuel': Actionables.sendTxWithoutSFuel,
        'MineAndSendFreeTx': Actionables.mineAndSendFreeTx,
        'dev: Mine Gas': Actionables.mineFreeGasInit,
        'dev: CreateSignedBulkTx': Actionables.createSignedBulkTx,
        'dev: StartMiningGasReserves': Actionables.startMiningReserves,
        'dev: ShowStats': Actionables.devShowStats
      })
    );
  }
}