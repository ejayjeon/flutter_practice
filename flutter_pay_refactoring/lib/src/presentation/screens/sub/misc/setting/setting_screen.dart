import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sketch_pay/src/shared/models/model.dart';
import 'package:sketch_pay/src/shared/styles/layouts/sub_list_layout.dart';
import 'package:sketch_pay/src/shared/utils/path_util.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // log(context.currentPath.toString(), name: "current");
    return SubListLayout(
      datas: [
        IconMenu(
          title: "언어 설정",
          iconPath: iconFilePath(fileName: "ic_language.svg", subFolder: "sub"),
          path: "/setting/language",
        ),
        IconMenu(
          title: "통화 선택",
          iconPath: iconFilePath(fileName: "ic_currency.svg", subFolder: "sub"),
          path: "/setting/currency",
        ),
        IconMenu(
          title: "알림 설정",
          iconPath: iconFilePath(fileName: "ic_notice.svg", subFolder: "sub"),
          path: "/setting/alert",
        ),
        IconMenu(
          title: "주소록 관리",
          iconPath:
              iconFilePath(fileName: "ic_address_book.svg", subFolder: "sub"),
          path: "/setting/address-book",
        ),
      ],
    );
  }
}
