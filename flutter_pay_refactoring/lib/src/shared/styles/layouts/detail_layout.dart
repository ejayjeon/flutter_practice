import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/routes/router.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';
import 'package:sketch_pay/src/shared/widgets/structure/sub_top_bar.dart';

class DetailLayout extends StatelessWidget {
  final String appBarTitle;
  final Widget child;
  final Color? color;
  final Color? appBarColor;
  final VoidCallback? onLeadingPressed;
  final PreferredSizeWidget? tabBar;
  final Widget? fab;
  const DetailLayout({
    super.key,
    required this.appBarTitle,
    required this.child,
    this.color,
    this.appBarColor,
    this.onLeadingPressed,
    this.tabBar,
    this.fab,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        backgroundColor: color ?? AppColor.bgGrey,
        appBar: _appBar(
          context,
          title: appBarTitle,
          color: appBarColor,
          onLeadingPressed: onLeadingPressed ??
              () {
                if (context.canPop()) {
                  context.pop();
                }
                context.goNamed(HomeRoute.path);
              },
          tabBar: tabBar,
        ),
        body: SizedBox.expand(
          child: child,
        ),
        floatingActionButton: fab,
      ),
    );
  }

  PreferredSizeWidget _appBar(
    BuildContext context, {
    VoidCallback? onLeadingPressed,
    Color? color,
    required String title,
    PreferredSizeWidget? tabBar,
  }) {
    return AppBar(
      backgroundColor: color ?? AppColor.black,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_outlined,
          color: AppColor.white,
        ),
        onPressed: onLeadingPressed,
      ),
      bottom: tabBar,
      title: Text(title, style: context.headerText),
    );
  }
}
