import 'dart:async';

import 'package:flutter/material.dart';

import '../components/particle_painter.dart';
import '../models/particle.dart';
import '../utilities/constants.dart';
import 'canvas_screen.dart';

class MainPage extends StatefulWidget {
  static const id = "/";
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late Timer timer;
  final particles = List<Particle>.generate(100, (index) => Particle());
  late AnimationController controller;
  late Animation animation;

  void fABColorAnimation() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..forward();
    controller.addListener(() {
      setState(() {});
    });
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    animation =
        ColorTween(begin: Colors.red, end: kFABColour).animate(controller);
  }

  void particleAnimation() {
    timer = Timer.periodic(const Duration(milliseconds: 1000 ~/ 60), (timer) {
      setState(() {
        for (final particle in particles) {
          particle.pos += Offset(particle.dx, particle.dy);
        }
      });
    });
  }

  @override
  void initState() {
    fABColorAnimation();
    particleAnimation();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            painter: ParticlePainter(particles: particles),
          ),
          Center(child: Image.asset("images/brush.png")),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: animation.value,
        onPressed: () async {
          controller.stop();
          timer.cancel();
          await Navigator.pushNamed(context, CanvasScreen.id);
          controller.forward();
          setState(() {
            particleAnimation();
          });
        },
        child: Image.asset("images/paint_brush.png"),
      ),
    );
  }
}
