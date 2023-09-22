import 'package:flutter/material.dart';
import 'package:wire_connection/shapes/drawable_node.dart';

//ignore: must_be_immutable
class CircularNode extends DrawableNode {
  CircularNode({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: 50,
        height: 50,
        color: Colors.green,
      ),
    );
  }

  @override
  String getShapeName() {
    return "Test Circular Node";
  }
}
