import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';

class AuthPinField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onCompleted;
  const AuthPinField({
    super.key,
    required this.controller,
    this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      controller: controller,
      length: 6,
      autoFocus: false,
      backgroundColor: Colors.transparent,
      cursorColor: AppColor.primary,
      animationType: AnimationType.fade,
      animationDuration: const Duration(milliseconds: 200),
      enableActiveFill: true,
      autoDismissKeyboard: true,
      autoDisposeControllers: false,
      keyboardType: TextInputType.number,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        activeColor: AppColor.primary,
        activeFillColor: AppColor.black,
        selectedColor: AppColor.primary,
        selectedFillColor: AppColor.black,
        inactiveColor: AppColor.disableColor,
        inactiveFillColor: AppColor.disableDarkColor,
        disabledColor: AppColor.disableColor,
        borderRadius: BorderRadius.circular(14.r),
        borderWidth: 1.0,
      ),
      textStyle: const TextStyle(
        color: AppColor.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      onCompleted: onCompleted,
      // errorTextSpace: 0,
    );
  }
}
