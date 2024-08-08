import 'package:flutter/material.dart';
import 'package:sketch_pay/src/shared/extensions/widget_extension.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';

class InfoTextWidget extends StatelessWidget {
  /// [강조하고 싶은 텍스트를 *안에 적을 것*]
  /// ex) 회원님의 *통합회원 아이디*를 입력해 주세요
  final String info;
  final Color focusedColor;
  const InfoTextWidget({
    super.key,
    required this.info,
    this.focusedColor = AppColor.primary,
  });

  @override
  Widget build(BuildContext context) {
    List<String> infoTextList = info.split("*");
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: RichText(
        text: TextSpan(
          children: List.generate(
            infoTextList.length,
            (index) => TextSpan(
              text: infoTextList[index],
              style: TextStyle(
                color: index % 2 != 0 ? focusedColor : AppColor.white,
                fontWeight:
                    index % 2 != 0 ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ).paddingSymmetric(size: const Size(0, 16)),
    );
  }
}
