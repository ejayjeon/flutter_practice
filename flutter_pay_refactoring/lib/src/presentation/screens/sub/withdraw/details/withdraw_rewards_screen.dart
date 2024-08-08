import 'package:flutter/material.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';
import 'package:sketch_pay/src/shared/styles/layouts/detail_layout.dart';

class WithdrawRewardsScreen extends StatelessWidget {
  const WithdrawRewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => ConstrainedBox(
          constraints: constraints,
          child: Container(
            color: AppColor.white,
          ),
        ),
      ),
    );
  }
}
