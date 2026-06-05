import 'package:flutter/material.dart';

class DottedLinePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double gapWidth;

  DottedLinePainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.dashWidth = 2.0,
    this.gapWidth = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    double startX = 0.0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + gapWidth;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}