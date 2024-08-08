import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/extensions/widget_extension.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';
import 'package:sketch_pay/src/shared/utils/image_util.dart';
import 'package:sketch_pay/src/shared/utils/path_util.dart';
import 'package:sketch_pay/src/shared/widgets/misc/balance_coin_type_span.dart';
import 'package:sketch_pay/src/shared/widgets/misc/balance_text_span.dart';

class MonetaryInfoCard extends StatelessWidget {
  const MonetaryInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ImageUtil.showImage(
          iconFilePath(fileName: "ic_coin.png", subFolder: "main"),
          fit: BoxFit.scaleDown,
          width: 200.sp,
          height: 200.sp,
        ).paddingSymmetric(size: const Size(4, 0)),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BalanceTextSpan(
              balance: "145.124123123",
              balanceTextSize: 28,
            ),
            BalanceCoinTypeSpan(coinType: '20'),
          ],
        ),

        /// Currency
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const BalanceTextSpan(
              balance: "100",
              balanceTextSize: 14,
              balanceTextColor: AppColor.white,
              decimalBalanceTextSize: 12,
            ),
            BalanceCoinTypeSpan(
              coinType: '00',
              textColor: AppColor.white.withOpacity(0.5),
              textSize: 12,
              textHeight: 2,
            ),
          ],
        ),

        /// 현재 보유수량
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "현재 보유 수량",
              style: context.bodyText?.copyWith(
                color: AppColor.white,
              ),
            ).paddingOnly(right: 8),
            const BalanceTextSpan(
              balance: "33249.3",
              balanceTextSize: 14,
              balanceTextColor: AppColor.primary,
              decimalBalanceTextSize: 12,
            ),
            BalanceCoinTypeSpan(
              coinType: '20',
              textColor: AppColor.primary.withOpacity(0.5),
              textSize: 12,
              textHeight: 2,
            ),
          ],
        ),
      ],
    );
  }
}
