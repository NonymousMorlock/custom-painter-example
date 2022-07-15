import 'package:flutter/material.dart';

import '../utilities/constants.dart';
import 'canvas_screen.dart';

class MainPage extends StatefulWidget {
  static const id = "/";
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/brush.png"),
          ),
        ),
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
