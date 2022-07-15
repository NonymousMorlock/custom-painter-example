import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../components/my_painter.dart';
import '../components/particle_painter.dart';
import '../models/particle.dart';
import '../models/stroke.dart';
import '../utilities/constants.dart';

class CanvasScreen extends StatefulWidget {
  static const id = '/canvas';
  const CanvasScreen({super.key});

  @override
  State<CanvasScreen> createState() => _CanvasScreenState();
}

class _CanvasScreenState extends State<CanvasScreen> {
  List<Stroke?> points = [];
  late Color selectedColor;
  late double strokeWidth;
  late Timer timer;
  final particles = List<Particle>.generate(100, (index) => Particle());

  void selectColor() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: selectedColor,
            onColorChanged: (color) {
              setState(() {
                selectedColor = color;
              });
            },
          ),
        ),
        actions: [
          ElevatedButton(
            child: const Text('Got it'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    selectedColor = Colors.black;
    strokeWidth = 2.0;
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
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            painter: ParticlePainter(particles: particles),
          ),
          Center(child: Image.asset("images/brush.png")),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: GestureDetector(
                  onPanDown: (details) {
                    setState(() {
                      points.add(
                        Stroke(
                          point: details.localPosition,
                          strokePaint: Paint()
                            ..color = selectedColor
                            ..strokeWidth = strokeWidth
                            ..isAntiAlias = true
                            ..strokeCap = StrokeCap.round,
                        ),
                      );
                    });
                  },
                  onPanUpdate: (details) {
                    setState(() {
                      points.add(
                        Stroke(
                          point: details.localPosition,
                          strokePaint: Paint()
                            ..color = selectedColor
                            ..strokeWidth = strokeWidth
                            ..isAntiAlias = true
                            ..strokeCap = StrokeCap.round,
                        ),
                      );
                    });
                  },
                  onPanEnd: (details) {
                    setState(() {
                      points.add(null);
                    });
                  },
                  child: Container(
                    height: height * 0.80,
                    width: width * 0.80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: Offset(5, 2.5),
                        ),
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: Offset(-5, 2.5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CustomPaint(
                        painter: MyPainter(
                          points: points,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height / (height / 20)),
              Container(
                width: width * 0.80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(5, 2.5),
                    ),
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(-5, 2.5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        selectColor();
                      },
                      icon: Icon(
                        Icons.color_lens,
                        color: selectedColor,
                      ),
                    ),
                    Expanded(
                        child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 2,
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: kSliderThumbRadius,
                        ),
                        overlayShape: const RoundSliderOverlayShape(
                          overlayRadius: kSliderOverlayRadius,
                        ),
                      ),
                      child: Slider(
                        min: 1,
                        max: 7,
                        value: strokeWidth,
                        activeColor: selectedColor,
                        onChanged: (value) {
                          setState(() {
                            strokeWidth = value;
                          });
                        },
                      ),
                    )),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            points.clear();
                          });
                        },
                        icon: const Icon(Icons.layers_clear)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
