import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/extensions/widget_extension.dart';
import 'package:sketch_pay/src/shared/routes/router.dart';
import 'package:sketch_pay/src/shared/styles/layouts/entrance_layout.dart';

class AfterLoginScreen extends ConsumerWidget {
  const AfterLoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EntranceLayout(
      child: Container(
        color: Colors.purpleAccent,
        child: ElevatedButton(
          onPressed: () {
            // GoRouter.of(context).pushReplacement(HomeRoute.path);
            context.go(HomeRoute.path);
          },
          child: Text("홈"),
        ).center,
      ),
    );
  }
}
