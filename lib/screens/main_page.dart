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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // about button
          FloatingActionButton(
            backgroundColor: animation.value,
            onPressed: () {
              /*showAboutDialog(
                context: context,
                applicationName: "Paint",
                applicationVersion: "1.0.0",
                applicationIcon: Image.asset("images/paint_brush.png"),
                applicationLegalese: "© 2023",
                children: [
                  const Text("Made with ❤️ by"),
                  const Text("Paul"),
                ],
              );*/

              /* POLICY
              Privacy Policy
Introduction
Our privacy policy will help you understand what information we collect at Paint, how Paint uses it, and what choices you have. We built the Paint app as a free app. This SERVICE is provided by us at no cost and is intended for use as is. If you choose to use our Service, then you should understand that there is no collection of information in relation with this policy.

Information Collection and Use
The app does NOT require you to provide us with personally identifiable information, including but not limited to users name, email address, gender, location, pictures. The app does use third party services that may collect information used to identify you.

Cookies
Cookies are files with small amount of data that is commonly used an anonymous unique identifier. These are sent to your browser from the website that you visit and are stored on your devices’s internal memory.

This Service does NOT use any “cookies”. Also, the app does NOT use third party code and libraries that use “cookies” to collect information.

Location Information
None of the services use location information from users' mobile phones.

Device Information
We do NOT collect information from your device.

Service Providers
We do NOT employ third-party companies and individuals.

Security
We do NOT ask you to provide us your Personal Information, thus we guarantee your absolute security.

Children’s Privacy
This Service addresses children under the age of 13. We do NOT collect personal identifiable information from children under 13. We made sure that no part of this app collects any input from its users hence children under 13 cannot mistakenly give us their personal information.

Changes to This Privacy Policy
We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page. These changes are effective immediately, after they are posted on this page.

Contact Us
If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us.
Contact Information:
Email: akundadababalei@gmail.com
               */

              // add privacy policy to the about dialog
              showAboutDialog(
                context: context,
                applicationName: "Paint",
                applicationVersion: "1.0.0",
                applicationIcon: Image.asset("images/paint_brush.png"),
                applicationLegalese: "© 2023",
                children: [
                  const Text("Made with ❤️ by"),
                  const Text("Paul"),
                  const SizedBox(height: 20.0),
                  const Text("Privacy Policy"),
                  const Text("Introduction"),
                  const Text(
                      "Our privacy policy will help you understand what information we collect at Paint, how Paint uses it, and what choices you have. We built the Paint app as a free app. This SERVICE is provided by us at no cost and is intended for use as is. If you choose to use our Service, then you should understand that there is no collection of information in relation with this policy."),
                  const Text("Information Collection and Use"),
                  const Text(
                      "The app does NOT require you to provide us with personally identifiable information, including but not limited to users name, email address, gender, location, pictures. The app does use third party services that may collect information used to identify you."),
                  const Text("Cookies"),
                  const Text(
                      "Cookies are files with small amount of data that is commonly used an anonymous unique identifier. These are sent to your browser from the website that you visit and are stored on your devices’s internal memory."),
                  const Text(
                      "This Service does NOT use any “cookies”. Also, the app does NOT use third party code and libraries that use “cookies” to collect information."),
                  const Text("Location Information"),
                  const Text(
                      "None of the services use location information from users' mobile phones."),
                  const Text("Device Information"),
                  const Text("We do NOT collect information from your device."),
                  const Text("Service Providers"),
                  const Text(
                      "We do NOT employ third-party companies and individuals."),
                  const Text("Security"),
                  const Text(
                      "We do NOT ask you to provide us your Personal Information, thus we guarantee your absolute security."),
                  const Text("Children’s Privacy"),
                  const Text(
                      "This Service addresses children under the age of 13. We do NOT collect personal identifiable information from children under 13. We made sure that no part of this app collects any input from its users hence children under 13 cannot mistakenly give us their personal information."),
                  const Text("Changes to This Privacy Policy"),
                  const Text(
                      "We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page. These changes are effective immediately, after they are posted on this page."),
                  const Text("Contact Us"),
                  const Text(
                      "If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us."),
                  const Text("Contact Information:"),
                  const Text("Email: akundadababalei@gmail.com"),
                ],
              );


            },
            child: Image.asset("images/about.png"),
          ),
          const SizedBox(height: 20.0),
          FloatingActionButton(
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
        ],
      ),
    );
  }
}
