import 'package:flutter/material.dart';

import '../models/particle.dart';

class ParticlePainter extends CustomPainter {
  List<Particle> particles;
  ParticlePainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    for(final particle in particles) {
      canvas.drawCircle(particle.pos, particle.radius, Paint()..style = PaintingStyle.fill);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }


}