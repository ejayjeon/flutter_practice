import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sketch_pay/src/shared/extensions/widget_extension.dart';
import 'package:sketch_pay/src/shared/routes/router.dart';
import 'package:sketch_pay/src/shared/styles/layouts/entrance_layout.dart';

class FindInfoDetailScreen extends ConsumerStatefulWidget {
  final String? id;
  const FindInfoDetailScreen({
    super.key,
    this.id,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FindInfoDetailScreenState();
}

class _FindInfoDetailScreenState extends ConsumerState<FindInfoDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return EntranceLayout(
      child: Container(
        color: Colors.purpleAccent,
        child: ElevatedButton(
          onPressed: () {
            GoRouter.of(context).pop();
            // context.go(HomeRoute.path);
          },
          child: Text("홈"),
        ).center,
      ),
    );
  }
}
