import 'package:flutter/material.dart';
import 'package:wire_connection/helper/unstable_annotation.dart';
import 'package:wire_connection/screen/home_screen.dart';

@Unstable(
  reason: "I am not sure whether the DrawableNode will be a Widget or"
      "something custom that can be drawn in the flutter canvas",
)
// ignore: must_be_immutable
abstract class DrawableNode extends StatelessWidget {
  DrawableNode({super.key}) {
    drawArrows();
  }

  /// shape name
  /// It will be used by other components of the
  /// app to show the type of the Shape this Node is.
  String shapeName = "";

  /// color for the background
  Color backgroundColor = Colors.white;

  /// color for the text inside of the node
  Color textColor = Colors.black;

  /// [hasConnectionsTo] has all the reference to the
  /// other nodes in the scene so that the drawer can make
  /// the connection wire from `this` to other [DrawableNode]
  /// Currently, a simple node can connect to at most 4 other nodes.
  DrawableNodeChild hasConnectionsTo = DrawableNodeChild();

  /// [currentPosition] is the offset value that store the position of this
  /// node in the scene in the canvas. Let's see how we implement this
  Offset currentPosition = Offset.zero;

  /// This needs to return the name of the Shape.
  /// It will be used by other components of the
  /// app to show the type of the Shape this Node is.
  String getShapeName() {
    return shapeName;
  }

  /// returns a new instance of this with properties copied
  DrawableNode newInstance();

  /// draw all the arrows that goes to the childrens
  void drawArrows() {}
}

/// [DrawableNodeChild]
///
/// This represents the four possible children of a given drawable
class DrawableNodeChild {
  DrawableNode? left;
  SelectedSide? leftTo;

  DrawableNode? right;
  SelectedSide? rightTo;

  DrawableNode? top;
  SelectedSide? topTo;

  DrawableNode? bottom;
  SelectedSide? bottomTo;
}
