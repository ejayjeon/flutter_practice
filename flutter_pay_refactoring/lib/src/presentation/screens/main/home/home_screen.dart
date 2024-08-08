import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sketch_pay/src/presentation/screens/main/home/widgets/point_card.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';
import 'package:sketch_pay/src/shared/widgets/paint/bar_chart.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log(context.currentPath.toString(), name: "current");
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: <Widget>[
          _pointCard(constraints),
          _rewardGrape(context, constraints),
          _transactionHistory(context, constraints),
        ],
      ),
    );
  }

  ConstrainedBox _transactionHistory(
    BuildContext context,
    BoxConstraints constraints,
  ) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: constraints.maxWidth,
        maxWidth: constraints.maxWidth,
        minHeight: constraints.minHeight -
            (constraints.minHeight / 4.5) -
            (constraints.minHeight / 4),
        maxHeight: constraints.maxHeight -
            (constraints.maxHeight / 4.5) -
            (constraints.maxHeight / 4),
      ),
      child: Container(
        padding: context.gap(size: const Size(14, 14)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "최근 내역",
              style: context.titleText?.copyWith(
                height: 0,
                color: AppColor.white,
              ),
            ),
            Expanded(
              child: _historySummury(context),
            ),
          ],
        ),
      ),
    );
  }

  ConstrainedBox _rewardGrape(
      BuildContext context, BoxConstraints constraints) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: constraints.maxWidth,
        maxWidth: constraints.maxWidth,
        minHeight: constraints.minHeight / 4,
        maxHeight: constraints.maxHeight / 4,
      ),
      child: Container(
          padding: context.gap(size: const Size(14, 14)),
          // color: AppColor.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "리워드 차트",
                style: context.titleText?.copyWith(
                  height: 0,
                  color: AppColor.white,
                ),
              ),
              const Expanded(
                child: BarChart(
                  percentage: 0.12,
                ),
              ),
            ],
          )
          // child: DonutChart(currentPercent: 0.52),
          ),
    );
  }

  ConstrainedBox _pointCard(BoxConstraints constraints) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: constraints.maxWidth,
        maxWidth: constraints.maxWidth,
        minHeight: constraints.minHeight / 4.5,
        maxHeight: constraints.maxHeight / 4.5,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(constraints.minWidth / 16),
          bottomRight: Radius.circular(constraints.minWidth / 16),
        ),
        child: Container(
          color: AppColor.black,
          child: PointCard(
            borderRadius: constraints.minWidth / 16,
          ),
        ),
      ),
    );
  }

  Widget _historySummury(BuildContext context) {
    return Column(
      children: <Widget>[
        // 날짜
        __historySummuryHeader(context),
        // 데이터
      ],
    );
  }

  Widget __historySummuryHeader(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          "2024-05-22",
          style:
              context.bodyText?.copyWith(color: AppColor.white, fontSize: 14),
        ),
        const Flexible(
          child: Divider(color: AppColor.white),
        ),
      ],
    );
  }

  Widget __historySummuryList(
    BuildContext context, {
    ScrollController? controller,
  }) {
    return ListView.builder(
      shrinkWrap: true,
      controller: controller,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: 1,
      itemBuilder: (_, index) {
        return const Column(
          children: <Widget>[],
        );
      },
    );
  }
}
