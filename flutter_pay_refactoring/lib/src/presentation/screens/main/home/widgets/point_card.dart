import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/extensions/widget_extension.dart';
import 'package:sketch_pay/src/shared/mixins/animation_controller_mixin.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';
import 'package:sketch_pay/src/shared/utils/image_util.dart';
import 'package:sketch_pay/src/shared/utils/misc_util.dart';
import 'package:sketch_pay/src/shared/utils/path_util.dart';
import 'package:sketch_pay/src/shared/widgets/misc/balance_text_span.dart';

class PointCard extends StatefulWidget {
  final VoidCallback? onPressed;
  final double? borderRadius;
  const PointCard({
    super.key,
    this.onPressed,
    this.borderRadius,
  });

  @override
  State<PointCard> createState() => _PointCardState();
}

class _PointCardState extends State<PointCard> with AnimationControllerMixin {
  late Animation<Gradient> _gradientAnimation;

  @override
  void initState() {
    super.initState();
    _gradientAnimation = Tween<Gradient>(
      begin: LinearGradient(
        colors: [
          AppColor.primary.withOpacity(0.05),
          AppColor.white.withOpacity(0.02),
        ],
        stops: const [0.0, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      end: LinearGradient(colors: [
        AppColor.primary.withOpacity(0.05),
        AppColor.white.withOpacity(0.02),
      ], stops: const [
        0.0,
        1.0
      ], begin: Alignment.bottomLeft, end: Alignment.topRight),
    ).animate(animationController);
  }

  @override
  int? get duration => 10;

  @override
  Widget build(BuildContext context) {
    // return AnimatedBuilder(
    //   animation: _gradientAnimation,
    //   builder: (_, child) => Container(
    //     decoration: BoxDecoration(
    //       gradient: _gradientAnimation.value,
    //     ),
    //     child: Center(
    //       child: Text("ddd"),
    //     ),
    //   ),
    // );
    return GestureDetector(
      onTap: widget.onPressed,
      child: ClipRRect(
        borderRadius:
            BorderRadius.all(Radius.circular(widget.borderRadius ?? 32)),
        child: AnimatedContainer(
          width: context.width,
          duration: Duration(seconds: duration!),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColor.primary.withOpacity(0.05),
                AppColor.white.withOpacity(0.02),
              ],
              stops: const [0.0, 1.0],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            // gradient: _gradientAnimation.value,
          ),
          child: Row(
            children: <Widget>[
              ImageUtil.showImage(
                iconFilePath(fileName: "ic_coin.png", subFolder: "main"),
                fit: BoxFit.scaleDown,
                width: 250.sp,
                height: 250.sp,
              ).paddingSymmetric(size: const Size(4, 0)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const BalanceTextSpan(
                          balance: "324114933.12311414",
                          balanceTextSize: 28,
                        ),
                        Text(
                          MiscUtil.switchCurrencyByCoinType('20'),
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          style: context.bodyText?.copyWith(
                            color: AppColor.primary,
                            fontSize: 12,
                            height: 1.5,
                          ),
                        ).intrinsitHeight,
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const BalanceTextSpan(
                          balance: "12",
                          balanceTextColor: AppColor.disableColor,
                          // balanceTextSize: 28,
                        ),
                        Text(
                          MiscUtil.switchCurrencyByCoinType('00'),
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          style: context.bodyText?.copyWith(
                            color: AppColor.disableColor,
                            fontSize: 12,
                            height: 1.5,
                          ),
                        ).intrinsitHeight,
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ).paddingOnly(right: 14),
        ),
      ).paddingOnly(bottom: 14, left: 14, right: 14),
    );
  }
}
