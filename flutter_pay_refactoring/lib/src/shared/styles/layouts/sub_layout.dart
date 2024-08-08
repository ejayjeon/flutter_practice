import 'package:flutter/material.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';
import 'package:sketch_pay/src/shared/widgets/structure/sub_top_bar.dart';

class SubLayout extends StatelessWidget {
  final PreferredSizeWidget? appbar;
  final Widget child;
  final Color? color;
  const SubLayout({
    super.key,
    this.appbar,
    required this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        backgroundColor: AppColor.bgGrey,
        appBar: appbar,
        body: child,
      ),
    );
  }
}
