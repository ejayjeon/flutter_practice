import 'package:flutter/material.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';

class SubTopBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final VoidCallback? onLeadingPressed;
  const SubTopBar({
    super.key,
    this.title,
    this.onLeadingPressed,
  });

  @override
  State<SubTopBar> createState() => _SubTopBarState();

  @override
  Size get preferredSize {
    double appBarHeight = kToolbarHeight;

    return Size.fromHeight(appBarHeight);
  }
}

class _SubTopBarState extends State<SubTopBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // toolbarHeight: preferredSize,
      backgroundColor: AppColor.white,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(
      //     bottom: Radius.circular(16.0),
      //   ),
      //   side: BorderSide(
      //     color: Colors.grey.shade400,
      //     width: 1.0,
      //   ),
      // ),
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(
          color: AppColor.borderColor,
          width: 1.0,
        ),
      ),
      automaticallyImplyLeading: true,
      centerTitle: true,
      leading: _leading(context, onPressed: widget.onLeadingPressed),
      title: _title(context, widget.title),
    );
  }

  Widget _title(BuildContext context, String? title) {
    return Text(
      title ?? "",
      style: context.titleText?.copyWith(
        color: AppColor.black,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _leading(
    BuildContext context, {
    VoidCallback? onPressed,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(
        Icons.arrow_back_ios_rounded,
      ),
    );
  }
}
