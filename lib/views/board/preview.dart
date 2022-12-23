import 'package:flutter/material.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/models/isar_models/tb_item.dart';

class TaskboardCardPreview extends StatefulWidget {
  const TaskboardCardPreview({super.key, required this.item});

  final TBItem item;

  @override
  State<TaskboardCardPreview> createState() => _TaskboardCardPreviewState();
}

class _TaskboardCardPreviewState extends State<TaskboardCardPreview> {
  late TBItem item;

  @override
  void initState() {
    super.initState();
    item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
          maxHeight: cardWidth * 0.55, maxWidth: cardWidth * 0.95),
      color: Colors.white10,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: item.boardColumns.length,
        itemBuilder: (context, index) {
          var columnItems = item.boardItems.toList();
          columnItems = columnItems
              .where(
                (element) => element.column == item.boardColumns[index].name,
              )
              .toList();
          return SizedBox(
            width: cardWidth * 0.20,
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black12)),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: (columnItems.length > 4) ? 4 : columnItems.length,
                itemBuilder: (context, index2) {
                  if (columnItems.length > 4 && index2 == 3) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 25,
                        width: double.infinity,
                        color: colors[index].withOpacity(0.90),
                        child: Center(
                          child: Text(
                            "+${columnItems.length - 3}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }
                  return Tooltip(
                    message: columnItems[index2].text,
                    verticalOffset: -13,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 25,
                        width: double.infinity,
                        color: colors[index].withOpacity(0.90),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
