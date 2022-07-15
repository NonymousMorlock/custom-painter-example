import 'package:flutter/material.dart';
import 'package:paint/screens/canvas_screen.dart';
import 'package:paint/screens/main_page.dart';
import 'package:paint/utilities/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppName,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: kMainColour,
      ),
      initialRoute: MainPage.id,
      routes: {
        MainPage.id: (_) => const MainPage(),
        CanvasScreen.id: (_) => const CanvasScreen(),
      },
    );
  }

}
