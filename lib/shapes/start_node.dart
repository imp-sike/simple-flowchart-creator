import 'package:flutter/material.dart';
import 'package:wire_connection/shapes/drawable_node.dart';

//ignore: must_be_immutable
class StartNode extends DrawableNode {
  StartNode({super.key}) {
    shapeName = "Start / End";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(1000000)),
        child: Text(
          getShapeName(),
          textAlign: TextAlign.center,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }

  @override
  DrawableNode newInstance() {
    return StartNode()
      ..textColor = textColor
      ..backgroundColor = backgroundColor
      ..currentPosition = currentPosition;
  }
}
