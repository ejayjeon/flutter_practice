import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/models/model.dart';
import 'package:sketch_pay/src/shared/routes/router.dart';
import 'package:sketch_pay/src/shared/styles/layouts/sub_list_layout.dart';
import 'package:sketch_pay/src/shared/utils/path_util.dart';

class WithdrawScreen extends ConsumerWidget {
  const WithdrawScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log(context.currentPath.toString(), name: "current");
    return SubListLayout(
      datas: [
        IconMenu(
          title: "충전 스케치 인출",
          iconPath:
              iconFilePath(fileName: "ic_withdraw_in.svg", subFolder: "sub"),
          path: "${WithdrawRoute.path}/${WithdrawHoldingsRoute.path}",
          // onPressed: () => context.go(WithdrawHoldingsRoute.path),
        ),
        IconMenu(
          title: "리워드 스케치 인출",
          iconPath:
              iconFilePath(fileName: "ic_withdraw_out.svg", subFolder: "sub"),
          path: "${WithdrawRoute.path}/${WithdrawRewardsRoute.path}",
          // onPressed: () => context.go(WithdrawRewardsRoute.path),
        ),
        // IconMenu(
        //   title: "스왑하기",
        //   iconPath: iconFilePath(fileName: "ic_withdraw.svg", subFolder: "sub"),
        // ),
      ],
    );
  }
}
