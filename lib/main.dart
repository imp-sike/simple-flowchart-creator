import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wire_connection/screen/home_screen.dart';
import 'package:wire_connection/screen/splash_screen.dart';

/// This will be used to load and compile the fragment shader later
/// Keeping this as global variable will refactor later
late FragmentProgram fragmentProgram;

Future<void> main() async {
  fragmentProgram = await FragmentProgram.fromAsset(
    'assets/shaders/khatra_shader.frag',
  );

  runApp(
    const BaseApp(),
  );
}

class BaseApp extends StatelessWidget {
  const BaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
