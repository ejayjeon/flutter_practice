import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/routes/router.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';
import 'package:sketch_pay/src/shared/styles/layouts/app_layout.dart';
import 'package:sketch_pay/src/shared/widgets/structure/app_drawer.dart';
import 'package:sketch_pay/src/shared/widgets/structure/app_navigation_bar.dart';
import 'package:sketch_pay/src/shared/widgets/structure/app_top_bar.dart';

class Main extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const Main({
    super.key,
    required this.navigationShell,
  });

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      scaffoldKey: _scaffoldKey,
      appbar: AppTopBar(
        title: context.currentPath.toString().replaceAll('/', ''),

        onLeadingPressed: () => _scaffoldKey.currentState?.openDrawer(),

        /// qr코드 버튼
        onActionPressed: () => context.go(QrRoute.path),
        // actionIconColor: AppColor.white, 로그인? white 비로그인? red
        actionCircleColor: AppColor.red, // ShakeMode ? red or disabled
      ),
      drawer: AppDrawer(
        onClosePressed: () => _scaffoldKey.currentState?.closeDrawer(),
      ),
      bottomNavigationBar: AppNavigationBar(
        selectedIndex: widget.navigationShell.currentIndex,
        onDestinationSelected: _goBranch,
      ),
      child: widget.navigationShell,
    );
  }
}
