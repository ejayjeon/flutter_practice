import 'package:flutter/material.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';
import 'package:sketch_pay/src/shared/utils/misc_util.dart';

class BalanceTextSpan extends StatelessWidget {
  final String balance;
  final Color? balanceTextColor;
  final double? balanceTextSize;
  final double? decimalBalanceTextSize;
  final double? textHeight;
  const BalanceTextSpan({
    super.key,
    required this.balance,
    this.balanceTextColor,
    this.balanceTextSize,
    this.decimalBalanceTextSize,
    this.textHeight,
  });

  @override
  Widget build(BuildContext context) {
    var intBalance = MiscUtil.splitBalance(balance)[0];
    var decimalBalance = MiscUtil.splitBalance(balance)[1];

    return Flexible(
      fit: FlexFit.loose,
      child: RichText(
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        text: TextSpan(
          text: MiscUtil.currencyFormatter(intBalance),
          style: context.headerText?.copyWith(
            color: balanceTextColor ?? AppColor.primary,
            fontSize: balanceTextSize ?? 24,
            height: textHeight ?? 1.2,
          ),
          children: <TextSpan>[
            TextSpan(
              text: '.',
              style: context.bodyText?.copyWith(
                color: balanceTextColor ?? AppColor.primary,
                fontSize: decimalBalanceTextSize ?? 16,
                height: 1.2,
              ),
            ),
            TextSpan(
              text: decimalBalance,
              style: context.bodyText?.copyWith(
                color: balanceTextColor ?? AppColor.primary,
                fontSize: decimalBalanceTextSize ?? 16,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
