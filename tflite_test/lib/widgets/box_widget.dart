// 인식된 객체에 맞는 경계 박스

import 'package:flutter/material.dart';
import 'package:tflite_test/models/recognition.dart';

class BoxWidget extends StatelessWidget {
  final Recognition result;
  const BoxWidget({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    // 결과에 따라 색상 지정
    Color color = Colors.primaries[((result.label?.length ?? 0) +
            result.label!.codeUnitAt(0) +
            (result.id ?? 0)) %
        Colors.primaries.length];
    return Positioned(
      left: result.renderLocation.left,
      top: result.renderLocation.top,
      width: result.renderLocation.width,
      height: result.renderLocation.height,
      child: Container(
        width: result.renderLocation.width,
        height: result.renderLocation.height,
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 3),
        ),
        child: Align(
          alignment: Alignment.topLeft,
          child: FittedBox(
            child: Container(
              color: color,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('${result.label} / ${result.score!.toStringAsFixed(2)}'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
