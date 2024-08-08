import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';
import 'package:sketch_pay/src/shared/widgets/paint/bar_chart.dart';

class DonutChart extends StatefulWidget {
  /// 0 ~ 1
  final double currentPercent;
  final Color color;

  const DonutChart({
    super.key,
    required this.currentPercent,
    this.color = AppColor.primary,
  });
  @override
  State<DonutChart> createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart> with TickerProviderStateMixin {
  double percentage = 0.0;
  double newPercentage = 0.0;

  late AnimationController percentageAnimationController;

  @override
  void initState() {
    super.initState();

    percentageAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 2000,
      ),
    )..addListener(() {
        setState(() {
          percentage = lerpDouble(
              percentage, newPercentage, percentageAnimationController.value)!;
        });
      });
    setState(() {
      percentage = newPercentage;
      newPercentage = widget.currentPercent;
      percentageAnimationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PercentDonut(percent: percentage, color: widget.color),
    );
  }
}

class PercentDonut extends StatelessWidget {
  const PercentDonut({super.key, required this.percent, required this.color});
  final percent;
  final color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width / 2,
      height: context.height / 2,
      child: CustomPaint(
        painter: PercentDonutPaint(
          percentage: percent,
          activeColor: color,
        ),
      ),
    );
  }
}

/// 도넛차트
class PercentDonutPaint extends CustomPainter {
  double percentage;
  double textScaleFactor = 0.3; // 파이 차트에 들어갈 텍스트 크기를 정합니다.
  Color activeColor;
  PercentDonutPaint({required this.percentage, required this.activeColor});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColor.disableColor
      ..strokeWidth = 15.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    double radius = min(
        size.width / 2 - paint.strokeWidth / 2,
        size.height / 2 -
            paint.strokeWidth / 2); // 원의 반지름을 구함. 선의 굵기에 영향을 받지 않게 보정함.
    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, paint);
    double arcAngle = 2 * pi * percentage; // 호(arc)의 각도를 정함. 정해진 각도만큼만 그리도록 함.
    paint.color = activeColor; // 호를 그릴 때는 색을 바꿔줌.
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, paint); // 호(arc)를 그림.

    // drawText(
    //     canvas, size, "${(percentage * 100).round()} / 100"); // 텍스트를 화면에 표시함.
    drawText(canvas, size, " ${(percentage * 100).round()}");
  }

  void drawText(Canvas canvas, Size size, String text) {
    double fontSize = getFontSize(size, text);

    TextSpan sp = TextSpan(
        text: "현재\n",
        style: TextStyle(
          fontSize: fontSize * 0.7,
          color: AppColor.primary,
        ),
        children: <TextSpan>[
          TextSpan(
            text: text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColor.primary,
            ),
          ),
          TextSpan(
            text: "%",
            style: TextStyle(
              fontSize: fontSize * 0.7,
              color: AppColor.primary,
            ),
          ),
        ]); // TextSpan은 Text위젯과 거의 동일하다.
    TextPainter tp = TextPainter(text: sp, textDirection: TextDirection.ltr);

    tp.layout(); // 필수! 텍스트 페인터에 그려질 텍스트의 크기와 방향를 정함.
    double dx = size.width / 2 - tp.width / 2;
    double dy = size.height / 2 - tp.height / 2;

    Offset offset = Offset(dx, dy);
    tp.paint(canvas, offset);
  }

  // 화면 크기에 비례하도록 텍스트 폰트 크기를 정함.
  double getFontSize(Size size, String text) {
    return size.width / text.length * textScaleFactor;
  }

  @override
  bool shouldRepaint(PercentDonutPaint oldDelegate) {
    return true;
  }
}
