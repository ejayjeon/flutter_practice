import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sketch_pay/src/shared/extensions/widget_extension.dart';
import 'package:sketch_pay/src/shared/routes/router.dart';
import 'package:sketch_pay/src/shared/styles/layouts/entrance_layout.dart';

class FindInfoScreen extends ConsumerWidget {
  const FindInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return HomeLayout(
    //   child: Container(),
    // );
    return EntranceLayout(
      child: Container(
        color: Colors.pinkAccent[400],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.go('${FindInfoRoute.path}/password');
                // context.go(HomeRoute.path);
              },
              child: const Text("FINDINFO"),
            ).center,
          ],
        ),
      ),
    );
  }
}
