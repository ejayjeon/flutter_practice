// 실시간으로 인식된 객체의 정보를 저장하고 처리

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tflite_test/settings/camera_settings.dart';

class Recognition {
  final int? _id;
  final String? _label;
  final double? _score;
  final Rect? _location;

  Recognition(this._id, this._label, this._score, [this._location]);

  int? get id => _id;
  String? get label => _label;
  double? get score => _score;
  Rect? get location => _location;

  // 객체의 위치를 화면에 맞게 변환해서 반환한다
  Rect get renderLocation {
    double? ratioX = CameraSettings.ratio;
    double? ratioY = ratioX;

    double transLeft = max(0.1, (location?.left ?? 0) * (ratioX ?? 0));

    double transTop = max(0.1, (location?.top ?? 0) * (ratioY ?? 0));

    double transWidth = min((location?.width ?? 0) * (ratioX ?? 0),
        CameraSettings.actualPreviewSize.width);

    double transHeight = min((location?.height ?? 0) * (ratioY ?? 0),
        CameraSettings.actualPreviewSize.height);

    Rect transformedRect =
        Rect.fromLTWH(transLeft, transTop, transWidth, transHeight);
    return transformedRect;
  }
}
