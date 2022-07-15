import 'package:flutter/material.dart';

import '../components/my_painter.dart';

class CanvasScreen extends StatefulWidget {
  static const id = '/canvas';
  const CanvasScreen({super.key});

  @override
  State<CanvasScreen> createState() => _CanvasScreenState();
}

class _CanvasScreenState extends State<CanvasScreen> {

  List<Offset?> points = [];

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onPanDown: (details) {
            setState(() {
              points.add(details.localPosition);
            });
          },
          onPanUpdate: (details) {
            setState(() {
              points.add(details.localPosition);
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
                painter: MyPainter(points: points),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
