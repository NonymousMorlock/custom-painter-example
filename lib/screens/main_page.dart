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

class _MainPageState extends State<MainPage> with TickerProviderStateMixin{

  late Timer timer;
  final particles = List<Particle>.generate(100, (index) => Particle());

  @override
  void initState() {
    timer = Timer.periodic(const Duration(milliseconds: 1000 ~/ 60), (timer) {
      setState(() {
       for(final particle in particles) {
         particle.pos += Offset(particle.dx, particle.dy);
       }
      });
    });
    super.initState();
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
        backgroundColor: kFABColour,
        onPressed: () {
          Navigator.pushNamed(context, CanvasScreen.id);
        },
        child: Image.asset("images/paint_brush.png"),
      ),
    );
  }
}
