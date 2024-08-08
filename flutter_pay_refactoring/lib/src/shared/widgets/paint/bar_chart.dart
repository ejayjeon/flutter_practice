import 'package:flutter/material.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';

class BarChart extends StatefulWidget {
  final double percentage;
  const BarChart({
    super.key,
    required this.percentage,
  });

  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return SizedBox(
          width: context.width,
          child: CustomPaint(
            painter: PercentBarPaint(
              percentage: _animation.value * widget.percentage,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

/// 바차트
///
class PercentBarPaint extends CustomPainter {
  double percentage;
  double textScaleFactor; // 텍스트 크기
  Color activeColor;
  PercentBarPaint({
    required this.percentage,
    this.textScaleFactor = 1,
    this.activeColor = AppColor.primary,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final barHeight = size.height * 0.15;
    final barWidth = size.width * percentage;

    /// 표시해줄 텍스트
    final textPainter = TextPainter(
      text: TextSpan(
        text: '${(percentage * 100).toInt()}%',
        style: TextStyle(
          color: AppColor.white,
          fontSize: barHeight * textScaleFactor,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    // 바 그리기
    final baseBarRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        0,
        (size.height - barHeight) / 2,
        size.width,
        barHeight,
      ),
      const Radius.circular(8.0),
    );

    final baseBarPaint = Paint()
      ..color = AppColor.disableColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;
    canvas.drawRRect(baseBarRect, baseBarPaint);

    /// 색깔 차트
    // final barRect = Rect.fromLTWH(
    //   0,
    //   (size.height - barHeight) / 2,
    //   barWidth,
    //   barHeight,
    // );
    final barRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        0,
        (size.height - barHeight) / 2,
        barWidth,
        barHeight,
      ),
      const Radius.circular(8.0),
    );

    /// 그라데이션 색상 지정
    const Gradient gradientColor = LinearGradient(
      colors: [
        Color(0xffb0f542),
        Color(0xffb0f542),
        Color(0xff42f5c2),
        // Color(0xff42f5f2),
        // Color(0xff59a1ff),
        // Color(0xff4a4dff),
        // Color(0xffa352ff),
        // Color(0xfff352ff),
        // Color(0xffff4fbc),
        // Color(0xffff3b79),
      ],
      stops: [
        0.0,
        // 0.1,
        // 0.2,
        // 0.3,
        // 0.4,
        // 0.5,
        // 0.6,
        // 0.7,
        0.8,
        1.0,
      ],
    );
    final barPaint = Paint()
      // ..color = activeColor
      ..shader = gradientColor.createShader(barRect.middleRect)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;
    canvas.drawRRect(barRect, barPaint);

    // 텍스트 그리기
    final textOffset = Offset(
      (size.width - textPainter.width) / 1,
      (size.height - textPainter.height) / 2,
    );
    textPainter.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(PercentBarPaint oldDelegate) {
    return oldDelegate.percentage != percentage ||
        oldDelegate.textScaleFactor != textScaleFactor ||
        oldDelegate.activeColor != activeColor;
  }
}
