
import 'package:flutter/material.dart';
import 'package:miner_skale_proto/components/transport_cmds.dart';

class TransportManual extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container( 
      color: Colors.brown.shade300,
      child: TransportCmds()
    );
  }
}