import 'package:flutter/material.dart';
import 'dart:math';

class ProgressPainter extends CustomPainter {
  Color defaultCircleColor;
  Color percentageCompletedCircleColor;
  double completedPercentage;
  double circleWidth;
  double totalSeconds;

  ProgressPainter(
      {this.defaultCircleColor,
      this.percentageCompletedCircleColor,
      this.completedPercentage,
      this.circleWidth,
      this.totalSeconds});

  @override
  void paint(Canvas canvas, Size size) {
    Paint defaultCirclePaint = getPaint(defaultCircleColor);
    Paint progressCirclePaint = getPaint(percentageCompletedCircleColor);

    Offset center = Offset(size.width / 2, size.height / 2);
    // double radius = min(size.width / 2, size.height / 2);

    // canvas.drawCircle(center, radius, defaultCirclePaint);

    double arcAngle = 2 * pi / 2 * (completedPercentage / totalSeconds);

    canvas.drawArc(
      Rect.fromCenter(
        center: center,
        height: size.height,
        width: size.width,
      ),
      0,
      pi,
      false,
      defaultCirclePaint,
    );

    canvas.drawArc(
      Rect.fromCenter(
        center: center,
        height: size.height,
        width: size.width,
      ),
      pi,
      -arcAngle,
      false,
      progressCirclePaint,
    );

    // canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
    //   arcAngle, false, progressCirclePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  Paint getPaint(Color defaultCircleColor) {
    return Paint()
      ..color = defaultCircleColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = circleWidth;
  }
}
