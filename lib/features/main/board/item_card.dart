import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/features/main/board/preview.dart';
import 'package:taskboard/helper.dart';
import 'package:taskboard/models/isar_models/tb_item.dart';
import 'package:taskboard/routes.dart';
import 'package:taskboard/app_state.dart';

class TaskboardItemCard extends StatelessWidget {
  const TaskboardItemCard(
      {Key? key, required this.columnColor, required this.item})
      : super(key: key);

  final Color columnColor;
  final TBItem item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cardWidth,
      child: GestureDetector(
        onTap: () async {
          await Provider.of<AppState>(context, listen: false).setBoard(item);
        },
        onDoubleTap: () {
          Navigator.push(context, openEditItemDialogbox(item));
        },
        child: Card(
          elevation: 0,
          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          child: ClipPath(
            clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: columnColor, width: 6),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        "[${item.id}] ${item.text}",
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    if (item.dueDate != null || item.priority != null)
                      const Divider(
                        height: 0,
                      ),
                    if (item.dueDate != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Due Date",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              getFormatedDate(item.dueDate!),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (item.priority != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Priority",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              item.priority.toString(),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    if (item.boardItems.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Align(
                          alignment: Alignment.center,
                          child: TaskboardPreview(
                            item: item,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
