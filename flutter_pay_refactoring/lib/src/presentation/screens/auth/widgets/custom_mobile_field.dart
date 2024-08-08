import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';

class CustomMobileField extends ConsumerWidget {
  final TextEditingController controller;
  final void Function(PhoneNumber)? onInputChanged;
  final String? Function(String?)? validator;
  final void Function()? onSubmit;
  final String? hintText;
  final Color focusedColor = AppColor.primary;
  final bool autofocus, enabled;
  final List<String>? countries;

  const CustomMobileField({
    super.key,
    required this.controller,
    this.onInputChanged,
    this.validator,
    this.onSubmit,
    this.hintText,
    this.autofocus = false,
    this.enabled = true,
    this.countries,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: context.gap(size: const Size(0, 16)),
      child: InternationalPhoneNumberInput(
        textFieldController: controller,
        onInputChanged: onInputChanged,
        keyboardAction: TextInputAction.next,
        selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          showFlags: true,
          useEmoji: false,
          setSelectorButtonAsPrefixIcon: true,
          trailingSpace: false,
          leadingPadding: 8,
        ),
        spaceBetweenSelectorAndTextField: 0,
        formatInput: false,
        inputDecoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: AppColor.black,
          focusColor: focusedColor,
          labelStyle: TextStyle(
            color: focusedColor,
            fontSize: 14,
          ),
          contentPadding: context.gap(size: const Size(12, 6)),
        ),
        autoFocus: autofocus,
        isEnabled: enabled,
        cursorColor: focusedColor,
        maxLength: 11,
        onSubmit: onSubmit,
        validator: validator,
        textStyle: const TextStyle(
          color: AppColor.white,
          fontSize: 16,
        ),
        selectorTextStyle: const TextStyle(
          color: AppColor.white,
          fontSize: 14,
        ),
        countries: countries,
      ),
    );
  }
}
