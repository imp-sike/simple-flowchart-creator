import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wire_connection/helper/context_extension.dart';
import 'package:wire_connection/helper/fragment_painter.dart';
import 'package:wire_connection/screen/home_screen.dart';

import '../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    // adding an animation for the iTime properties of the fragment shader
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    animation = Tween<double>(begin: 0, end: 12.5).animate(animationController);

    animationController.addListener(() {
      setState(() {});
    });

    animationController.forward().then((value) {
      context.navigateToReplace(const HomeScreen());
    });

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: context.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(300.0),
              child: CustomPaint(
                painter: FragmentPainter(
                  Colors.green,
                  shader: fragmentProgram.fragmentShader(),
                  time: animation.value,
                ),
                child: SizedBox(
                  width: context.width * 0.1,
                  height: context.height * 0.2,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Fake splash screen to show my shader skill...",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
