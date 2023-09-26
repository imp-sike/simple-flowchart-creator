import 'package:flutter/material.dart';
import 'package:wire_connection/screen/home_screen.dart';
import 'package:wire_connection/shapes/drawable_node.dart';

/// [ArrowPainter]
///
/// This painter is responsible to detect all the active connections in the
/// list of nodes [drawableNodes] and draw a arrow from the offset
/// of first node to second node of the two connected nodes.
///
/// We have to check for all the four directions (see [DrawableNodeChild])
/// and draw them respectively.
///
/// Currently arrows does not have any arrow head.
class ArrowPainter extends CustomPainter {
  List<DrawableNode> drawableNodes;

  ArrowPainter(this.drawableNodes);

  @override
  void paint(Canvas canvas, Size size) {
    // we will be using a black coloured line to draw all the arrows
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

    _loopAllNodeAndDrawConnector(canvas, paint);
  }

  void _loopAllNodeAndDrawConnector(Canvas canvas, Paint paint) {
    for (var item in drawableNodes) {
      // left
      _checkAndConnectIfPossible(
        item: item,
        canvas: canvas,
        paint: paint,
        current: item.hasConnectionsTo.left,
        currentSide: item.hasConnectionsTo.leftTo,
        leftOffset: const Offset(10, 40),
        rightOffset: const Offset(115, 40),
        topOffset: const Offset(65, 10),
        bottomOffset: const Offset(65, 70),
        leftAlternativeOffset: const Offset(10, 40),
        rightAlternativeOffset: const Offset(10, 40),
        topAlternativeOffset: const Offset(10, 40),
        bottomAlternativeOffset: const Offset(10, 40),
      );

      // right
      _checkAndConnectIfPossible(
        item: item,
        canvas: canvas,
        paint: paint,
        current: item.hasConnectionsTo.right,
        currentSide: item.hasConnectionsTo.rightTo,
        leftAlternativeOffset: const Offset(130, 40),
        leftOffset: const Offset(10, 40),
        rightAlternativeOffset: const Offset(130, 40),
        rightOffset: const Offset(115, 40),
        topAlternativeOffset: const Offset(130, 40),
        topOffset: const Offset(65, 10),
        bottomAlternativeOffset: const Offset(130, 40),
        bottomOffset: const Offset(65, 70),
      );

      // top
      _checkAndConnectIfPossible(
        item: item,
        canvas: canvas,
        paint: paint,
        current: item.hasConnectionsTo.top,
        currentSide: item.hasConnectionsTo.topTo,
        leftAlternativeOffset: const Offset(65, 10),
        leftOffset: const Offset(10, 40),
        rightAlternativeOffset: const Offset(65, 10),
        rightOffset: const Offset(115, 40),
        topAlternativeOffset: const Offset(65, 10),
        topOffset: const Offset(65, 10),
        bottomAlternativeOffset: const Offset(65, 10),
        bottomOffset: const Offset(65, 70),
      );

      // bottom
      _checkAndConnectIfPossible(
        item: item,
        canvas: canvas,
        paint: paint,
        current: item.hasConnectionsTo.bottom,
        currentSide: item.hasConnectionsTo.bottomTo,
        leftAlternativeOffset: const Offset(65, 75),
        leftOffset: const Offset(10, 40),
        rightAlternativeOffset: const Offset(65, 75),
        rightOffset: const Offset(115, 40),
        topAlternativeOffset: const Offset(65, 75),
        topOffset: const Offset(65, 10),
        bottomAlternativeOffset: const Offset(65, 75),
        bottomOffset: const Offset(65, 70),
      );
    }
  }

  void _checkAndConnectIfPossible({
    required DrawableNode item,
    required Canvas canvas,
    required Paint paint,
    required DrawableNode? current,
    required SelectedSide? currentSide,
    required Offset leftOffset,
    required Offset rightOffset,
    required Offset topOffset,
    required Offset bottomOffset,
    required Offset leftAlternativeOffset,
    required Offset rightAlternativeOffset,
    required Offset topAlternativeOffset,
    required Offset bottomAlternativeOffset,
  }) {
    if (current != null || currentSide != null) {
      switch (currentSide) {
        case null:
          break;
        case SelectedSide.left:
          canvas.drawLine(item.currentPosition + leftAlternativeOffset,
              current!.currentPosition + leftOffset, paint);
          break;
        case SelectedSide.right:
          canvas.drawLine(item.currentPosition + rightAlternativeOffset,
              current!.currentPosition + rightOffset, paint);
          break;
        case SelectedSide.top:
          canvas.drawLine(item.currentPosition + topAlternativeOffset,
              current!.currentPosition + topOffset, paint);
          break;
        case SelectedSide.bottom:
          canvas.drawLine(item.currentPosition + bottomAlternativeOffset,
              current!.currentPosition + bottomOffset, paint);
          break;
      }
    }
  }

  @override
  bool shouldRepaint(ArrowPainter oldDelegate) {
    return true;
  }
}
