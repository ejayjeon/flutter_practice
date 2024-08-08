import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';

class CustomTextField extends ConsumerWidget {
  final TextEditingController controller;
  final bool autofocus, readOnly, isPassword, enabled;
  final int maxLine;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted, onChanged;
  final TextInputFormatter? inputFormatter;
  final InputDecoration? inputDecoration;
  final String? hintText, labelText;
  final Color focusedColor;
  const CustomTextField({
    super.key,
    required this.controller,
    this.autofocus = false,
    this.readOnly = false,
    this.isPassword = false,
    this.enabled = true,
    this.maxLine = 1,
    this.validator,
    this.inputFormatter,
    this.onFieldSubmitted,
    this.onChanged,
    this.inputDecoration,
    this.hintText,
    this.labelText,
    this.focusedColor = AppColor.primary,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      decoration: inputDecoration ??
          InputDecoration(
            label: Text(labelText ?? ""),
            filled: true,
            fillColor: AppColor.black,
            hintText: hintText,
            focusColor: focusedColor,
            contentPadding: context.gap(size: const Size(12, 12)),
            labelStyle: TextStyle(
              color: focusedColor,
              fontSize: 14,
            ),
          ),
      style: const TextStyle(
        color: AppColor.white,
        fontSize: 14,
      ),
      cursorColor: focusedColor,
      controller: controller,
      autofocus: autofocus,
      readOnly: readOnly,
      obscureText: isPassword,
      enabled: enabled,
      maxLines: 1,
      maxLength: null,
      validator: validator,
      inputFormatters: inputFormatter != null
          ? [
              inputFormatter!,
            ]
          : null,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
    );
  }
}
