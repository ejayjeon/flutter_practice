import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sketch_pay/src/shared/models/model.dart';
import 'package:sketch_pay/src/shared/styles/layouts/sub_list_layout.dart';
import 'package:sketch_pay/src/shared/utils/path_util.dart';

class CurrencyScreen extends ConsumerWidget {
  const CurrencyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SubListLayout(
      datas: [
        IconMenu(
          title: "KRW",
          iconPath:
              iconFilePath(fileName: "ic_check_off.svg", subFolder: "sub"),
          useCheckItem: true,
          subTitle: "",
        ),
        IconMenu(
          title: "USD",
          iconPath:
              iconFilePath(fileName: "ic_check_off.svg", subFolder: "sub"),
          useCheckItem: true,
          subTitle: "",
        ),
      ],
    );
  }
}
