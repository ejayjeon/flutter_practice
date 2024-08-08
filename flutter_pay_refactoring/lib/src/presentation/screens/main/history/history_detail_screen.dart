import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sketch_pay/src/data/models/model.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/extensions/widget_extension.dart';
import 'package:sketch_pay/src/shared/routes/router.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';
import 'package:sketch_pay/src/shared/styles/layouts/detail_layout.dart';
import 'package:sketch_pay/src/shared/utils/image_util.dart';

class HistoryDetailScreen extends ConsumerWidget {
  // final String id;
  final ParamList data;
  const HistoryDetailScreen({
    super.key,
    required this.data,
    // required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log(data.toJson().toString(), name: "HistoryDetail");
    return DetailLayout(
      appBarTitle: "${data.categoryNm} 내역",
      onLeadingPressed: () =>
          context.canPop() ? context.pop() : context.go(HistoryRoute.path),
      child: Container(
        color: AppColor.black,
        padding: context.gap(size: const Size(12, 36)),
        child: _receiptContainer(
          context,
          child: const Text("dd"),
        ),
      ),
    );
  }

  /// [영수증 모양]
  Widget _receiptContainer(
    BuildContext context, {
    required Widget child,
  }) {
    return Column(
      children: <Widget>[
        ImageUtil.showImage("assets/images/zigzag_top.png"),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) => Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              color: AppColor.white,
              child: child.center,
            ),
          ),
        ),
        ImageUtil.showImage("assets/images/zigzag_bottom.png"),
      ],
    ).center;
  }

  ///
}
