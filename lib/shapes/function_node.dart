import 'package:flutter/material.dart';
import 'package:wire_connection/shapes/drawable_node.dart';

//ignore: must_be_immutable
class FunctionNode extends DrawableNode {
  FunctionNode({super.key}) {
    shapeName = "Function";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: Colors.black),
        ),
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
    return FunctionNode()
      ..textColor = textColor
      ..backgroundColor = backgroundColor
      ..currentPosition = currentPosition;
  }
}
