import 'package:flutter/material.dart';
import 'package:wire_connection/shapes/drawable_node.dart';

//ignore: must_be_immutable
class ProcessNode extends DrawableNode {
  ProcessNode({super.key}) {
    shapeName = "Processing";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
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
    ProcessNode processNode = ProcessNode()
      ..textColor = textColor
      ..backgroundColor = backgroundColor
      ..currentPosition = currentPosition
      ..hasConnectionsTo = hasConnectionsTo;
    return processNode;
  }
}
