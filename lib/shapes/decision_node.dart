import 'package:flutter/material.dart';
import 'package:wire_connection/helper/arrow_painter.dart';
import 'package:wire_connection/shapes/drawable_node.dart';

//ignore: must_be_immutable
class DecisionNode extends DrawableNode {
  DecisionNode({super.key}) {
    shapeName = "Decision Node";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ClipPath(
        clipper: DecisionNodeClipper(),
        child: Container(
          color: backgroundColor,
          child: CustomPaint(
            painter: DecisionNodeBorder(),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                getShapeName(),
                textAlign: TextAlign.center,
                style: TextStyle(color: textColor),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  DrawableNode newInstance() {
    return DecisionNode()
      ..textColor = textColor
      ..backgroundColor = backgroundColor
      ..currentPosition = currentPosition;
  }
}

class DecisionNodeBorder extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.black;

    final path = Path();

    path.moveTo(size.width * 0.5, 0); // Move to the top center.
    path.lineTo(size.width, size.height * 0.5); // Draw to the middle right.
    path.lineTo(size.width * 0.5, size.height); // Draw to the bottom center.
    path.lineTo(0, size.height * 0.5); // Draw to the middle left.
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DecisionNodeClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final path = Path();

    path.moveTo(size.width * 0.5, 0); // Move to the top center.
    path.lineTo(size.width, size.height * 0.5); // Draw to the middle right.
    path.lineTo(size.width * 0.5, size.height); // Draw to the bottom center.
    path.lineTo(0, size.height * 0.5); // Draw to the middle left.
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
