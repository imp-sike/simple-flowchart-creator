import 'package:flutter/material.dart';
import 'package:wire_connection/screen/home_screen.dart';

void main() => runApp(const BaseApp());

class BaseApp extends StatelessWidget {
  const BaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
