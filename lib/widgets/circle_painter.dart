import 'package:flutter/material.dart';

class CircleProgressBarPainter extends CustomPainter {
  final double progress;

  CircleProgressBarPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 8.0
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    canvas.drawCircle(center, radius, paint);

    final progressPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 8.0
      ..style = PaintingStyle.stroke;

    final sweepAngle = 360.0 * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -90 * (3.14159265358979323846264338327950288 / 180),
      360 * (3.14159265358979323846264338327950288 / 180) * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}