import 'package:flutter/material.dart';
import 'package:wire_connection/helper/arrow_painter.dart';
import 'package:wire_connection/helper/context_extension.dart';
import 'package:wire_connection/shapes/input_output_node.dart';
import 'package:wire_connection/shapes/process.dart';
import 'package:wire_connection/shapes/start_node.dart';

import '../shapes/drawable_node.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum SelectedSide { left, right, top, bottom }

class _HomeScreenState extends State<HomeScreen> {
  final List<DrawableNode> _drawableNodes = [];
  late final List<DrawableNode> _uniqueNodes;
  int currentSelectedDrawableNode = 0;
  final TextEditingController labelTextEditingController =
      TextEditingController();
  bool isActivated = false;
  SelectedSide selectedSideFromNode = SelectedSide.left;
  SelectedSide selectedSideToNode = SelectedSide.left;

  // two nodes are selected for arrowing
  int toNode = -2;

  @override
  void initState() {
    _uniqueNodes = [StartNode(), IONode(), ProcessNode()];
    super.initState();
  }

  @override
  void dispose() {
    labelTextEditingController.dispose();
    super.dispose();
  }

  void createConnection() {
    if (toNode == -2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Can not create connection"),
        ),
      );
    } else {
      switch (selectedSideFromNode) {
        case SelectedSide.left:
          _drawableNodes[currentSelectedDrawableNode].hasConnectionsTo.left =
              _drawableNodes[toNode];
          _drawableNodes[currentSelectedDrawableNode].hasConnectionsTo.leftTo =
              selectedSideToNode;
          break;
        case SelectedSide.right:
          _drawableNodes[currentSelectedDrawableNode].hasConnectionsTo.right =
              _drawableNodes[toNode];
          _drawableNodes[currentSelectedDrawableNode].hasConnectionsTo.rightTo =
              selectedSideToNode;
          break;
        case SelectedSide.top:
          _drawableNodes[currentSelectedDrawableNode].hasConnectionsTo.top =
              _drawableNodes[toNode];
          _drawableNodes[currentSelectedDrawableNode].hasConnectionsTo.topTo =
              selectedSideToNode;
          break;

        case SelectedSide.bottom:
          _drawableNodes[currentSelectedDrawableNode].hasConnectionsTo.bottom =
              _drawableNodes[toNode];
          _drawableNodes[currentSelectedDrawableNode]
              .hasConnectionsTo
              .bottomTo = selectedSideToNode;
          break;
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createConnection();
        },
        child: const Icon(Icons.line_axis),
      ),
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: context.width * 0.2,
              height: context.height,
              color: Colors.red,
              child: ListView.builder(
                itemCount: _uniqueNodes.length,
                itemBuilder: (BuildContext context, int index) {
                  return Draggable<DrawableNode>(
                    data: _uniqueNodes[index],
                    feedback: Material(child: _uniqueNodes[index]),
                    child: _uniqueNodes[index],
                  );
                },
              ),
            ),
            DragTarget(
              onAccept: (data) {
                if (data is DrawableNode) {
                  _drawableNodes.add(data.newInstance());
                  currentSelectedDrawableNode = _drawableNodes.length - 1;
                  labelTextEditingController.text =
                      _drawableNodes[_drawableNodes.length - 1].getShapeName();

                  setState(() {});
                }
              },
              builder: (BuildContext context, List<Object?> candidateData,
                  List<dynamic> rejectedData) {
                return Container(
                  width: context.width * 0.6,
                  height: context.height,
                  color: Colors.grey,
                  child: Stack(
                    children: [
                      ...buildStackItems(),
                      IgnorePointer(
                        ignoring: true,
                        child: CustomPaint(
                          painter: ArrowPainter(_drawableNodes),
                          child: Container(
                            width: context.width * 0.6,
                            height: context.height,
                            color: Colors.amber.withAlpha(70),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Container(
              width: context.width * 0.2,
              color: Colors.green,
              height: context.height,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    const Text("Editor Tab"),
                    _drawableNodes.isEmpty
                        ? Container()
                        : TextField(
                            onChanged: (String newValue) {
                              _drawableNodes[currentSelectedDrawableNode]
                                  .shapeName = newValue;
                              setState(() {});
                            },
                            controller: labelTextEditingController,
                            decoration: const InputDecoration(
                                hintText: "Label Diagram"),
                          )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDraggable(DrawableNode item, BuildContext context, int index,
      {bool selected = false}) {
    return GestureDetector(
      onLongPress: () {
        _drawableNodes.removeAt(index);
        setState(() {});
        context.showSnackBar("Deleted...");
      },
      onTap: () {
        isActivated = !isActivated;
        currentSelectedDrawableNode = index;
        labelTextEditingController.text = _drawableNodes[index].getShapeName();
        setState(() {});
      },
      child: Draggable<String>(
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
        feedback: Material(child: item),
        child: Container(
            decoration: selected
                ? BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  )
                : null,
            child: item),
      ),
    );
  }

  List<Widget> buildStackItems() {
    List<Widget> listOfStackItems = [];
    int i = 0;

    for (var item in _drawableNodes) {
      listOfStackItems.add(
        isActivated
            ? Container(
                key: ValueKey(i), child: buildSingleSelectedItem(item, i))
            : Positioned(
                key: ValueKey(i),
                left: item.currentPosition.dx,
                top: item.currentPosition.dy,
                child: buildDraggable(item, context, i),
              ),
      );
      i++;
    }
    return listOfStackItems;
  }

  Positioned buildSingleSelectedItem(DrawableNode item, int i) {
    return Positioned(
      left: item.currentPosition.dx,
      top: item.currentPosition.dy,
      child: Stack(
        children: [
          buildDraggable(item, context, i,
              selected: i == currentSelectedDrawableNode),
          Positioned(
            left: 0,
            top: 32,
            child: GestureDetector(
              onTap: () {
                if (i == currentSelectedDrawableNode) {
                  selectedSideFromNode = SelectedSide.left;
                } else {
                  toNode = i;
                  selectedSideToNode = SelectedSide.left;
                }
                setState(() {});
              },
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(500),
                  color: ((currentSelectedDrawableNode == i &&
                              selectedSideFromNode == SelectedSide.left) ||
                          (selectedSideToNode == SelectedSide.left &&
                              i == toNode))
                      ? Colors.red
                      : Colors.purple,
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 32,
            child: GestureDetector(
              onTap: () {
                if (i == currentSelectedDrawableNode) {
                  selectedSideFromNode = SelectedSide.right;
                } else {
                  toNode = i;

                  selectedSideToNode = SelectedSide.right;
                }
                setState(() {});
              },
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(500),
                  color: ((currentSelectedDrawableNode == i &&
                              selectedSideFromNode == SelectedSide.right) ||
                          (selectedSideToNode == SelectedSide.right &&
                              i == toNode))
                      ? Colors.red
                      : Colors.purple,
                ),
              ),
            ),
          ),
          Positioned(
            left: 55,
            top: 0,
            child: GestureDetector(
              onTap: () {
                if (i == currentSelectedDrawableNode) {
                  selectedSideFromNode = SelectedSide.top;
                } else {
                  toNode = i;

                  selectedSideToNode = SelectedSide.top;
                }
                setState(() {});
              },
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(500),
                  color: ((currentSelectedDrawableNode == i &&
                              selectedSideFromNode == SelectedSide.top) ||
                          (selectedSideToNode == SelectedSide.top &&
                              i == toNode))
                      ? Colors.red
                      : Colors.purple,
                ),
              ),
            ),
          ),
          Positioned(
            left: 55,
            bottom: 0,
            child: GestureDetector(
              onTap: () {
                if (i == currentSelectedDrawableNode) {
                  selectedSideFromNode = SelectedSide.bottom;
                } else {
                  toNode = i;
                  selectedSideToNode = SelectedSide.bottom;
                }
                setState(() {});
              },
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(500),
                  color: ((currentSelectedDrawableNode == i &&
                              selectedSideFromNode == SelectedSide.bottom) ||
                          (selectedSideToNode == SelectedSide.bottom &&
                              i == toNode))
                      ? Colors.red
                      : Colors.purple,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
