import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/extensions/datetime_extension.dart';
import 'package:sketch_pay/src/shared/extensions/widget_extension.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';
import 'package:sketch_pay/src/shared/utils/image_util.dart';
import 'package:sketch_pay/src/shared/utils/path_util.dart';
import 'package:sketch_pay/src/shared/widgets/misc/balance_coin_type_span.dart';
import 'package:sketch_pay/src/shared/widgets/misc/balance_text_span.dart';

class ProductInfoCard extends StatelessWidget {
  final double constraintHeight;
  final double constraintWidth;
  const ProductInfoCard({
    super.key,
    required this.constraintHeight,
    required this.constraintWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: constraintWidth,
      height: constraintHeight,
      padding: context.gap(size: const Size(12, 12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RichText(
            text: TextSpan(
              text: DateTime.now().yy_MM_dd,
              style: context.bodyText?.copyWith(
                color: AppColor.white,
                fontWeight: FontWeight.bold,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: " 주문",
                  style: context.bodyText?.copyWith(
                    fontWeight: FontWeight.normal,
                    color: AppColor.white,
                  ),
                ),
              ],
            ),
          ).paddingOnly(bottom: 4, top: 8),
          _paymentInfo(context).paddingOnly(bottom: 12),
          _productInfo(
            context,
            productImagePath: 'assets/images/ebitmall.png',
            productTitle:
                "상품타이틀상품타이틀상품타이틀상품타이틀상품타이틀상품타이틀상품타이틀상품타이틀상품타이틀상품타이틀상품타이틀",
            productPrice: "39999",
            productCoinType: "00",
          ),
        ],
      ),
    );
  }

  Widget _paymentInfo(BuildContext context) {
    return Container(
      padding: context.gap(size: const Size(24, 24)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.black,
      ),
      child: Column(
        children: <Widget>[
          _paymentTitleInfo(
            context,
            children: [
              Text(
                "결제 정보",
                style: context.titleText?.copyWith(
                  color: AppColor.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _paymentRowInfo(context,
                  rowTitle: "결제금액", value: "100", coinType: "00"),
              _paymentRowInfo(context,
                  rowTitle: "배송료", value: "0", coinType: "00"),
              _paymentRowInfo(context,
                  rowTitle: "결제수단", value: "pay", isBalance: false),
            ],
          ),
          const Divider(
            color: AppColor.white,
            thickness: 2,
          ),
          _paymentRowInfo(
            context,
            rowTitle: "총 결제금액",
            value: "100",
            coinType: "00",
            fontSize: 16,
          ),
        ],
      ),
    );
  }

  Widget _paymentTitleInfo(
    BuildContext context, {
    required List<Widget> children,
  }) {
    return Row(
      children: <Widget>[
        const CircleAvatar(
          backgroundImage: AssetImage("assets/images/ebitmall.png"),
        ).paddingOnly(right: 36.sp),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ],
    ).paddingOnly(bottom: 36.sp);
  }

  Widget _paymentRowInfo(
    BuildContext context, {
    required String rowTitle,
    String? coinType,
    required String value,
    bool isBalance = true,
    double? fontSize,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          rowTitle,
          style: context.bodyText?.copyWith(
            color: AppColor.white,
            fontWeight: FontWeight.w500,
            fontSize: fontSize ?? 14,
          ),
        ),
        if (isBalance) ...[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              BalanceTextSpan(
                balance: value,
                balanceTextColor: AppColor.white,
                balanceTextSize: fontSize ?? 14,
                decimalBalanceTextSize: 12,
              ),
              BalanceCoinTypeSpan(
                coinType: coinType ?? '20',
                textColor: AppColor.white,
                textSize: fontSize ?? 12,
                textFontWeight: FontWeight.normal,
              ).paddingOnly(left: 4)
            ],
          ),
        ] else ...[
          Text(
            value,
            style: context.bodyText?.copyWith(
              fontSize: 12,
              color: AppColor.white,
            ),
          ),
        ],
      ],
    );
  }

  Widget _productInfo(
    BuildContext context, {
    String? productImagePath,
    String? productTitle,
    String? productPrice,
    String? productCoinType,
  }) {
    return Container(
      padding: context.gap(size: const Size(24, 24)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.black,
      ),
      child: Row(
        // mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ImageUtil.showImage(
            productImagePath ?? 'assets/images/test.png',
            width: 80,
            height: 80,
          ).paddingOnly(right: 16),
          Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: context.width / 2,
                child: Text(
                  productTitle ?? "상품타이틀",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.titleText?.copyWith(
                    color: AppColor.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    height: 1.2,
                  ),
                ).paddingOnly(bottom: 12),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  BalanceTextSpan(
                    balance: productPrice ?? "0",
                    balanceTextColor: AppColor.white,
                    balanceTextSize: 16,
                    decimalBalanceTextSize: 14,
                  ),
                  BalanceCoinTypeSpan(
                    coinType: productCoinType ?? "20",
                    textColor: AppColor.white,
                    textFontWeight: FontWeight.normal,
                    textSize: 14,
                  ).paddingOnly(left: 4),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
