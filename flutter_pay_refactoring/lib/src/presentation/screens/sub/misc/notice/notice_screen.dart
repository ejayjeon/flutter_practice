import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sketch_pay/src/shared/models/model.dart';
import 'package:sketch_pay/src/shared/styles/layouts/sub_list_layout.dart';
import 'package:sketch_pay/src/shared/utils/path_util.dart';

class NoticeScreen extends ConsumerWidget {
  const NoticeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // log(context.currentPath.toString(), name: "current");
    return SubListLayout(
      datas: [
        IconMenu(
          title: "공지사항",
          iconPath: iconFilePath(fileName: "ic_notice.svg", subFolder: "sub"),
        ),
        IconMenu(
          title: "자주 묻는 질문",
          iconPath: iconFilePath(fileName: "ic_faq.svg", subFolder: "sub"),
        ),
        IconMenu(
          title: "이용 약관",
          iconPath: iconFilePath(fileName: "ic_term.svg", subFolder: "sub"),
        ),
        IconMenu(
            title: "앱 버전 정보",
            iconPath:
                iconFilePath(fileName: "ic_version.svg", subFolder: "sub"),
            subTitle: "현재 버전"),
      ],
    );
  }
}
