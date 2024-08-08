import 'package:flutter/material.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/extensions/widget_extension.dart';
import 'package:sketch_pay/src/shared/mixins/animation_controller_mixin.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';
import 'package:sketch_pay/src/shared/utils/image_util.dart';

class AppTopBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final VoidCallback? onLeadingPressed;
  final VoidCallback? onActionPressed;
  final Color? actionIconColor;
  final Color? actionCircleColor;
  final bool onLogin;
  const AppTopBar({
    super.key,
    this.title,
    this.onLeadingPressed,
    this.onActionPressed,
    this.actionIconColor,
    this.actionCircleColor,
    this.onLogin = false,
  });

  @override
  State<AppTopBar> createState() => _AppTopBarState();

  @override
  Size get preferredSize {
    double appBarHeight = kToolbarHeight;

    return Size.fromHeight(appBarHeight);
  }
}

class _AppTopBarState extends State<AppTopBar> with AnimationControllerMixin {
  @override
  int? get duration => 1000;
  @override
  Widget? get animationChild => SizedBox(
        child: RotationTransition(
          turns: animationController,
          child: const Icon(
            Icons.refresh,
            color: AppColor.primary,
          ),
        ),
      ).center;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.black,
      title: _title(context, widget.title),
      centerTitle: true,
      automaticallyImplyLeading: true,
      leading: _leading(
        context,
        onPressed: widget.onLeadingPressed,
        onLogin: widget.onLogin,
      ),
      actions: [
        _action(context, widget.onActionPressed, widget.actionIconColor,
            widget.actionCircleColor),
      ],
    );
  }

  Widget _title(BuildContext context, String? title) {
    return Text(
      title ?? "",
      // style: context.titleText?.copyWith(
      //   color: AppColor.white,
      //   fontWeight: FontWeight.bold,
      // ),
      style: context.headerText,
    );
  }

  Widget _leading(
    BuildContext context, {
    VoidCallback? onPressed,
    required bool onLogin,
  }) {
    return onLogin
        ? animationChild!
        : IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.menu,
              color: AppColor.white,
            ),
          );
  }

  Widget _action(
    BuildContext context,
    VoidCallback? onPressed,
    Color? color,
    Color? circleColor,
  ) {
    return IconButton(
      onPressed: onPressed,
      icon: Stack(
        children: <Widget>[
          ImageUtil.showImage(
            "assets/icons/main/ic_scan.svg",
            color: color ?? AppColor.white,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: circleColor ?? AppColor.disableColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
