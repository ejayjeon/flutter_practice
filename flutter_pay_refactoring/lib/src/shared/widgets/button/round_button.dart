import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';

class RoundButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double height;
  final Color? borderColor;
  final Color? backgroundColor;
  final String label;

  const RoundButton({
    super.key,
    this.onPressed,
    this.height = 50.0,
    this.borderColor,
    this.backgroundColor,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height),
          color: backgroundColor ?? Colors.transparent,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: context.bodyText,
        ),
      ),
    );
  }
}
