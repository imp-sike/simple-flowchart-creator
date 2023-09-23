import 'package:flutter/material.dart';
import 'package:wire_connection/helper/arrow_painter.dart';
import 'package:wire_connection/shapes/drawable_node.dart';

//ignore: must_be_immutable
class IONode extends DrawableNode {
  IONode({super.key}) {
    shapeName = "I/O Node";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ClipPath(
        clipper: IONodeClipper(),
        child: Container(
          padding: const EdgeInsets.all(10),
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
    IONode ioNode = IONode()
      ..textColor = textColor
      ..backgroundColor = backgroundColor
      ..currentPosition = currentPosition;
    return ioNode;
  }
}

class IONodeClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final path = Path();
    // Create the four points of the parallelogram.
    final point1 = Offset(0.1 * size.width, 0);
    final point2 = Offset(size.width, 0);
    final point3 = Offset(size.width * 0.9, size.height);
    final point4 = Offset(0, size.height);

    // Add the four points to the path.
    path.moveTo(point1.dx, point1.dy);
    path.lineTo(point2.dx, point2.dy);
    path.lineTo(point3.dx, point3.dy);
    path.lineTo(point4.dx, point4.dy);

    // Close the path.
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
