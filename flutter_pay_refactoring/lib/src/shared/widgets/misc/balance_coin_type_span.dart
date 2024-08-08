import 'package:flutter/cupertino.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/extensions/widget_extension.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';
import 'package:sketch_pay/src/shared/utils/misc_util.dart';

class BalanceCoinTypeSpan extends StatelessWidget {
  final String coinType;
  final Color? textColor;
  final double? textSize;
  final FontWeight? textFontWeight;
  final double? textHeight;
  const BalanceCoinTypeSpan({
    super.key,
    required this.coinType,
    this.textColor,
    this.textSize,
    this.textFontWeight,
    this.textHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      MiscUtil.switchCurrencyByCoinType(coinType),
      overflow: TextOverflow.clip,
      maxLines: 1,
      style: context.bodyText?.copyWith(
        color: textColor ?? AppColor.primary.withOpacity(0.5),
        fontSize: textSize ?? 18,
        fontWeight: textFontWeight ?? FontWeight.bold,
        height: textHeight ?? 1.5,
      ),
    ).intrinsitHeight;
  }
}
