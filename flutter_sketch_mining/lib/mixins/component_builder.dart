import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miner_skale_proto/actions/basic_cubit.dart';
import 'package:miner_skale_proto/actions/mode_actions.dart';
import 'package:miner_skale_proto/actions/actionables.dart';

mixin ComponentBuilder<T extends BasicCubit> {

  List<Widget> createUserActionButtons(
    BuildContext context, 
    Map<String, Actionables> params
  ) {
  return 
    params
    .entries 
    .map((e) =>
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(double.infinity),
              backgroundColor: Colors.grey.shade200,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero
              ),
            ),
            onPressed: () => context.read<T>().onPressed(e.value),
            child: Text(e.key),
          ),
        )
    )).toList();
  }
}