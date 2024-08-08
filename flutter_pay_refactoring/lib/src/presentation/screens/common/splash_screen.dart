import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sketch_pay/src/shared/extensions/widget_extension.dart';
import 'package:sketch_pay/src/shared/routes/router.dart';
import 'package:sketch_pay/src/shared/styles/layouts/entrance_layout.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EntranceLayout(
      child: Container(
        color: Colors.amber,
        child: ElevatedButton(
          onPressed: () {
            context.go(LoginRoute.path);
          },
          child: const Text("버튼"),
        ).center,
      ),
    );
  }
}
