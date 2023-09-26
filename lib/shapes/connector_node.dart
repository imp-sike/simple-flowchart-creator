import 'package:flutter/material.dart';
import 'package:wire_connection/shapes/drawable_node.dart';

//ignore: must_be_immutable
class ConnectorNode extends DrawableNode {
  ConnectorNode({super.key}) {
    shapeName = "Connect";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: CircleAvatar(
        radius: 51,
        backgroundColor: Colors.black,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 50,
          child: Container(
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(1000000)),
            child: Text(
              getShapeName(),
              textAlign: TextAlign.center,
              style: TextStyle(color: textColor),
            ),
          ),
        ),
      ),
    );
  }

  @override
  DrawableNode newInstance() {
    return ConnectorNode()
      ..textColor = textColor
      ..backgroundColor = backgroundColor
      ..currentPosition = currentPosition;
  }
}
