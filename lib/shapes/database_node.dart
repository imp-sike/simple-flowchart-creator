import 'package:flutter/material.dart';
import 'package:wire_connection/helper/arrow_painter.dart';
import 'package:wire_connection/shapes/drawable_node.dart';

//ignore: must_be_immutable
class DatabaseNode extends DrawableNode {
  DatabaseNode({super.key}) {
    shapeName = "Database Node";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ClipPath(
        clipper: DecisionNodeClipper(),
        child: Container(
          padding: const EdgeInsets.all(20),
          color: backgroundColor,
          child: Text(
            getShapeName(),
            textAlign: TextAlign.center,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }

  @override
  DrawableNode newInstance() {
    return DatabaseNode()
      ..textColor = textColor
      ..backgroundColor = backgroundColor
      ..currentPosition = currentPosition;
  }
}

class DecisionNodeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    double centerX = size.width * 0.5;
    double centerY = size.height;
    double radius = size.width * 0.4; // Adjust the radius as needed.

    path.moveTo(
        centerX + radius, centerY); // Move to the right side of the base.

    // Draw the curved top of the cylinder.
    path.arcToPoint(
      Offset(centerX - radius,
          centerY), // Ending point on the left side of the base.
      radius: Radius.circular(radius),
      clockwise: false,
    );

    // Draw the left side of the cylinder.
    path.lineTo(centerX - radius, size.height);

    // Draw the bottom of the cylinder.
    path.lineTo(centerX + radius, size.height);

    // Close the path to complete the shape.
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
