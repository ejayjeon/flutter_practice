import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/extensions/widget_extension.dart';
import 'package:sketch_pay/src/shared/styles/layouts/sub_layout.dart';

class FamilyAppScreen extends ConsumerWidget {
  const FamilyAppScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log(context.currentPath.toString(), name: "current");
    return Container(
      child: const Text("패밀리앱").center,
    );
  }
}
