import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sketch_pay/src/shared/extensions/widget_extension.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Size? paddingSize;
  final IconData? icon;
  final Color color, borderColor, disabledColor, labelColor;
  final bool disabled, isOutlineButton, needRadius;
  final double? height, width;
  const AppButton({
    super.key,
    this.onPressed,
    this.label = "확인",
    this.paddingSize,
    this.icon,
    this.color = AppColor.primary,
    this.borderColor = AppColor.borderColor,
    this.disabledColor = AppColor.disableColor,
    this.labelColor = AppColor.white,
    this.disabled = false,
    this.isOutlineButton = false,
    this.needRadius = true,
    this.height = 48,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: color.withOpacity(0.3),
      onTap: !disabled ? onPressed : null,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: !disabled ? color : disabledColor,
          borderRadius: needRadius ? BorderRadius.circular(8) : null,
          border: isOutlineButton ? Border.all(color: borderColor) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (icon != null) ...[
              Icon(
                icon,
                color: borderColor,
              ),
            ],
            Text(
              label,
              style: TextStyle(
                color: isOutlineButton ? borderColor : labelColor,
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ).paddingSymmetric(
        size: paddingSize ?? const Size(8, 12),
      ),
    );
  }
}
