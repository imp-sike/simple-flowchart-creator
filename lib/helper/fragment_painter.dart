import 'dart:ui';

import 'package:flutter/material.dart';

/// [FragmentPainter]
///
/// This is responsible to draw the fragment shader file
class FragmentPainter extends CustomPainter {
  Color color;
  FragmentShader shader;
  double time;

  FragmentPainter(this.color, {required this.shader, required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, time);

    Paint paint = Paint()..shader = shader;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(FragmentPainter oldDelegate) {
    return oldDelegate.time != time;
  }
}
