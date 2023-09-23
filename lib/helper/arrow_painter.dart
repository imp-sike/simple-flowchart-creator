import 'package:flutter/material.dart';
import 'package:wire_connection/screen/home_screen.dart';
import 'package:wire_connection/shapes/drawable_node.dart';

class ArrowPainter extends CustomPainter {
  List<DrawableNode> drawableNodes;

  ArrowPainter(this.drawableNodes);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

    for (var item in drawableNodes) {
      if (item.hasConnectionsTo.left != null ||
          item.hasConnectionsTo.leftTo != null) {
        switch (item.hasConnectionsTo.leftTo) {
          case null:
            break;
          case SelectedSide.left:
            canvas.drawLine(
                item.currentPosition + const Offset(10, 40),
                item.hasConnectionsTo.left!.currentPosition +
                    const Offset(10, 40),
                paint);
            break;
          case SelectedSide.right:
            canvas.drawLine(
                item.currentPosition + const Offset(10, 40),
                item.hasConnectionsTo.left!.currentPosition +
                    const Offset(115, 40),
                paint);
            break;
          case SelectedSide.top:
            canvas.drawLine(
                item.currentPosition + const Offset(10, 40),
                item.hasConnectionsTo.left!.currentPosition +
                    const Offset(65, 10),
                paint);
            break;
          case SelectedSide.bottom:
            canvas.drawLine(
                item.currentPosition + const Offset(10, 40),
                item.hasConnectionsTo.left!.currentPosition +
                    const Offset(65, 70),
                paint);
            break;
        }
      }

      if (item.hasConnectionsTo.right != null ||
          item.hasConnectionsTo.rightTo != null) {
        switch (item.hasConnectionsTo.rightTo) {
          case null:
            break;
          case SelectedSide.left:
            canvas.drawLine(
                item.currentPosition + const Offset(130, 40),
                item.hasConnectionsTo.right!.currentPosition +
                    const Offset(10, 40),
                paint);
            break;
          case SelectedSide.right:
            canvas.drawLine(
                item.currentPosition + const Offset(130, 40),
                item.hasConnectionsTo.right!.currentPosition +
                    const Offset(115, 40),
                paint);
            break;
          case SelectedSide.top:
            canvas.drawLine(
                item.currentPosition + const Offset(130, 40),
                item.hasConnectionsTo.right!.currentPosition +
                    const Offset(65, 10),
                paint);
            break;
          case SelectedSide.bottom:
            canvas.drawLine(
                item.currentPosition + const Offset(130, 40),
                item.hasConnectionsTo.right!.currentPosition +
                    const Offset(65, 70),
                paint);
            break;
        }
      }

      if (item.hasConnectionsTo.top != null ||
          item.hasConnectionsTo.topTo != null) {
        switch (item.hasConnectionsTo.topTo) {
          case null:
            break;
          case SelectedSide.left:
            canvas.drawLine(
                item.currentPosition + const Offset(65, 10),
                item.hasConnectionsTo.top!.currentPosition +
                    const Offset(10, 40),
                paint);
            break;
          case SelectedSide.right:
            canvas.drawLine(
                item.currentPosition + const Offset(65, 10),
                item.hasConnectionsTo.top!.currentPosition +
                    const Offset(115, 40),
                paint);
            break;
          case SelectedSide.top:
            canvas.drawLine(
                item.currentPosition + const Offset(65, 10),
                item.hasConnectionsTo.top!.currentPosition +
                    const Offset(65, 10),
                paint);
            break;
          case SelectedSide.bottom:
            canvas.drawLine(
                item.currentPosition + const Offset(65, 10),
                item.hasConnectionsTo.top!.currentPosition +
                    const Offset(65, 70),
                paint);
            break;
        }
      }

      if (item.hasConnectionsTo.bottom != null ||
          item.hasConnectionsTo.bottomTo != null) {
        switch (item.hasConnectionsTo.bottomTo) {
          case null:
            break;
          case SelectedSide.left:
            canvas.drawLine(
                item.currentPosition + const Offset(65, 75),
                item.hasConnectionsTo.bottom!.currentPosition +
                    const Offset(10, 40),
                paint);
            break;
          case SelectedSide.right:
            canvas.drawLine(
                item.currentPosition + const Offset(65, 75),
                item.hasConnectionsTo.bottom!.currentPosition +
                    const Offset(115, 40),
                paint);
            break;
          case SelectedSide.top:
            canvas.drawLine(
                item.currentPosition + const Offset(65, 75),
                item.hasConnectionsTo.bottom!.currentPosition +
                    const Offset(65, 10),
                paint);
            break;
          case SelectedSide.bottom:
            canvas.drawLine(
                item.currentPosition + const Offset(65, 75),
                item.hasConnectionsTo.bottom!.currentPosition +
                    const Offset(65, 70),
                paint);
            break;
        }
      }
    }
  }

  @override
  bool shouldRepaint(ArrowPainter oldDelegate) {
    return true;
  }
}
