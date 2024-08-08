import 'package:flutter/material.dart';
import 'package:sketch_pay/src/shared/extensions/widget_extension.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';
import 'package:sketch_pay/src/shared/styles/layouts/detail_layout.dart';
import 'package:sketch_pay/src/shared/widgets/button/app_button.dart';

class WithdrawHoldingsScreen extends StatelessWidget {
  const WithdrawHoldingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => ConstrainedBox(
          constraints: constraints,
          child: Container(
            color: AppColor.white,
            child: Column(
              children: <Widget>[
                _holdingCount(
                  context,
                  color: AppColor.red,
                  child: Container(),
                ).flex(flex: 1),
                _holdingCount(
                  context,
                  color: AppColor.primary,
                  child: Container(),
                ).flex(flex: 3),
                _applyButton(context).flex(flex: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _holdingCount(
    BuildContext context, {
    Color? color,
    required Widget child,
  }) {
    return Container(
      color: color,
      child: child,
    );
  }

  Widget _applyButton(
    BuildContext context, {
    VoidCallback? onPressed,
  }) {
    return AppButton(
      color: AppColor.yellow,
      disabled: true /* state.disable */,
      labelColor: AppColor.black,
      label: "인출 신청",
      onPressed: onPressed,
    ).center;
  }
}
