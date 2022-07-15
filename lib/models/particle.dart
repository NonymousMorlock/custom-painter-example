import 'dart:math';

import 'package:flutter/material.dart';

class Particle {

  Particle() {
    radius = Utils.range(3, 10);
    color = Colors.black26;
    final x = Utils.range(0, 400);
    final y = Utils.range(0, 700);
    pos = Offset(x, y);
    dx = Utils.range(-0.1, 0.1);
    dy = Utils.range(-0.1, 0.1);
  }

  late double radius;
  late Color color;
  late Offset pos;
  late double dx;
  late double dy;
}

final rng = Random();

class Utils {
  static double range(double min, double max) => rng.nextDouble() * (max - min) + min;
}