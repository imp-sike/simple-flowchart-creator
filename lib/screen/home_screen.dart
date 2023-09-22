import 'package:flutter/material.dart';
import 'package:wire_connection/extension/context_extension.dart';
import 'package:wire_connection/shapes/input_output_node.dart';
import 'package:wire_connection/shapes/process.dart';
import 'package:wire_connection/shapes/start_node.dart';

import '../shapes/drawable_node.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<DrawableNode> _drawableNodes = [];
  late final List<DrawableNode> _uniqueNodes;
  int currentSelectedDrawableNode = 0;
  final TextEditingController labelTextEditingController =
      TextEditingController();

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
                    children: [...buildStackItems()],
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

  Widget buildDraggable(DrawableNode item, BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text(index.toString()),
        //   ),
        // );
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
        child: item,
      ),
    );
  }

  List<Widget> buildStackItems() {
    List<Widget> listOfStackItems = [];
    int i = 0;

    for (var item in _drawableNodes) {
      listOfStackItems.add(Positioned(
        left: item.currentPosition.dx,
        top: item.currentPosition.dy,
        child: buildDraggable(item, context, i),
      ));
      i++;
    }
    return listOfStackItems;
  }
}
