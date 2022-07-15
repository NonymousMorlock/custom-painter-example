import 'dart:ui';

import 'package:flutter/material.dart';

import '../models/stroke.dart';

class MyPainter extends CustomPainter {
  List<Stroke?> points;

  MyPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundColor = Paint()..color = Colors.white;
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    /// paint background
    canvas.drawRect(rect, backgroundColor);

    /// draw based on user gestures
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        final paint = points[i]!.strokePaint;
        canvas.drawLine(points[i]!.point, points[i + 1]!.point, paint);
      } else if (points[i] != null && points[i + 1] == null) {
        final paint = points[i]!.strokePaint;
        canvas.drawPoints(PointMode.points, [points[i]!.point], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
