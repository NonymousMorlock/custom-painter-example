import 'dart:ui';

import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  List<Offset?> points;

  MyPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundColor = Paint()..color = Colors.white;
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    /// paint background
    canvas.drawRect(rect, backgroundColor);

    /// draw based on user gestures
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      } else if (points[i] != null && points[i + 1] == null) {
        canvas.drawPoints(PointMode.points, [points[i]!], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
