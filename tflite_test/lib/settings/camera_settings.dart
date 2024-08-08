import 'package:flutter/material.dart';

class CameraSettings {
  static double? ratio;
  static Size? screenSize;
  static Size? inputImageSize;
  static Size get actualPreviewSize => Size(
        screenSize?.width ?? 0, // 화면 너비
        (screenSize?.width ?? 0) * (ratio ?? 0), // 화면 너비에 비율을 곱해서 계산
      );
}
