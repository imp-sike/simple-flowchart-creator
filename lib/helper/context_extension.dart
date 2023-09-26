import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void navigateToReplace(Widget screen) {
    Navigator.of(this).pushReplacement(
      MaterialPageRoute(
        builder: (_) => screen,
      ),
    );
  }
}
