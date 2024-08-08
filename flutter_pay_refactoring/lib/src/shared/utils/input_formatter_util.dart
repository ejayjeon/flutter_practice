import 'dart:math';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class InputFormatterUtil extends TextInputFormatter {
  final RegExp _allowedPattern = RegExp(r'^[0-9,]*(\.[0-9,]*)?$');
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (!_allowedPattern.hasMatch(newValue.text)) {
      return oldValue;
    }

    final newText = newValue.text;
    final dotIndex = newText.indexOf('.');

    String formattedText;
    int offsetAdjustment = 0;

    if (dotIndex == -1) {
      if (newText.length > 17) return oldValue;
      formattedText = _formatNumber(newText);
    } else {
      final integerPart = newText.substring(0, dotIndex);
      final decimalPart = newText.substring(dotIndex + 1);

      if (integerPart.length > 17 || decimalPart.length > 18) return oldValue;

      formattedText = '${_formatNumber(integerPart)}.$decimalPart';
    }

    // 커서 위치 조정
    offsetAdjustment = _calculateCursorOffset(
        oldValue.text, formattedText, newValue.selection.end);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(
          offset: min(offsetAdjustment, formattedText.length)),
    );
  }

  String _formatNumber(String number) {
    if (number.isEmpty) {
      return '';
    }

    final numericOnly = number.replaceAll(',', '');
    final formatter = NumberFormat('#,##0');
    return formatter.format(int.tryParse(numericOnly) ?? 0);
  }

  int _calculateCursorOffset(
      String oldText, String newText, int oldCaretPosition) {
    int offset = oldCaretPosition;

    // 콤마 추가에 따른 커서 위치 조정
    int commaCountOld = oldText
            .substring(0, min(oldCaretPosition, oldText.length))
            .split(',')
            .length -
        1;
    int commaCountNew =
        newText.substring(0, min(offset, newText.length)).split(',').length - 1;
    offset += (commaCountNew - commaCountOld);
    // 위치
    return offset;
  }
}
