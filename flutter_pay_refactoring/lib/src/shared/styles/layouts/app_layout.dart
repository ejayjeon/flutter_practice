import 'package:flutter/material.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';
import 'package:sketch_pay/src/shared/widgets/structure/app_top_bar.dart';

class MainLayout extends StatelessWidget {
  final String? title;
  final PreferredSizeWidget? appbar;
  final Widget child;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Widget? endDrawer;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  const MainLayout({
    super.key,
    this.title,
    this.appbar,
    required this.child,
    this.drawer,
    this.endDrawer,
    this.bottomNavigationBar,
    this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        key: scaffoldKey,
        appBar: appbar,
        backgroundColor: AppColor.backGround,
        body: SizedBox.expand(
          child: child,
        ),
        drawer: drawer,
        endDrawer: endDrawer,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
