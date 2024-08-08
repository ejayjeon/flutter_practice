import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sketch_pay/src/shared/extensions/widget_extension.dart';
import 'package:sketch_pay/src/shared/routes/router.dart';
import 'package:sketch_pay/src/shared/styles/layouts/entrance_layout.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return EntranceLayout(
      child: Container(
        color: Colors.pinkAccent[400],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // context.go('${LoginRoute.path}/success');
                context.go(HomeRoute.path);
              },
              child: const Text("AfterLogin"),
            ).center,
            ElevatedButton(
              onPressed: () {
                context.go(FindInfoRoute.path);
              },
              child: const Text("FindInfo"),
            ).center,
          ],
        ),
      ),
    );
  }
}
