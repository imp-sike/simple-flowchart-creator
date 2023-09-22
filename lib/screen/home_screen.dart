import 'package:flutter/material.dart';
import 'package:wire_connection/extension/context_extension.dart';
import 'package:wire_connection/shapes/test_circular_node.dart';

import '../shapes/drawable_node.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<DrawableNode> _drawableNodes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: context.width * 0.2,
              height: context.height,
              color: Colors.red,
              child: Wrap(
                children: [
                  Draggable<DrawableNode>(
                    data: CircularNode(),
                    feedback: CircularNode(),
                    child: CircularNode(),
                  ),
                ],
              ),
            ),
            DragTarget(
              onAccept: (data) {
                if (data is DrawableNode) {
                  _drawableNodes.add(data);
                  setState(() {});
                }
              },
              builder: (BuildContext context, List<Object?> candidateData,
                  List<dynamic> rejectedData) {
                return SizedBox(
                  width: context.width * 0.6,
                  height: context.height,
                  child: Stack(
                    children: [
                      for (var item in _drawableNodes)
                        Positioned(
                          left: item.currentPosition.dx,
                          top: item.currentPosition.dy,
                          child: buildDraggable(item, context),
                        )
                    ],
                  ),
                );
              },
            ),
            Container(
              width: context.width * 0.2,
              color: Colors.green,
              height: context.height,
            ),
          ],
        ),
      ),
    );
  }

  Draggable<String> buildDraggable(DrawableNode item, BuildContext context) {
    return Draggable<String>(
      childWhenDragging: Container(),
      onDragEnd: (DraggableDetails details) {
        if (details.offset.dx > 0.2 * context.width &&
            details.offset.dx < 0.8 * context.width) {
          item.currentPosition = Offset(
              details.offset.dx - 0.2 * context.width, details.offset.dy);

          setState(() {});
        }
      },
      data: "not_req",
      feedback: item,
      child: item,
    );
  }
}
