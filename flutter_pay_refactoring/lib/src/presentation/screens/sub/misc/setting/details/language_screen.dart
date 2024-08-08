import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sketch_pay/src/shared/models/model.dart';
import 'package:sketch_pay/src/shared/styles/layouts/sub_list_layout.dart';
import 'package:sketch_pay/src/shared/utils/path_util.dart';

class LanguageScreen extends ConsumerWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SubListLayout(
      datas: [
        IconMenu(
          title: "한국어",
          iconPath:
              iconFilePath(fileName: "ic_check_off.svg", subFolder: "sub"),
          useCheckItem: true,
          subTitle: "",
        ),
        IconMenu(
          title: "영어",
          iconPath:
              iconFilePath(fileName: "ic_check_off.svg", subFolder: "sub"),
          useCheckItem: true,
          subTitle: "",
        ),
      ],
    );
  }
}
