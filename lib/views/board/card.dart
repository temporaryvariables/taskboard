import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/models/isar_models/item.dart';
import 'package:taskboard/routes.dart';
import 'package:taskboard/state/app_state.dart';
import 'package:taskboard/views/board/preview.dart';

class BoardCard extends StatelessWidget {
  const BoardCard({Key? key, required this.item}) : super(key: key);

  final Item item;

  String getFormatedDate(DateTime date) {
    return "${date.month}/${date.day}/${date.year}";
  }

  Color getColumnColor() {
    var parentItemColumn = item.parentItem.value!.boardColumns;
    var isarColumn =
        parentItemColumn.where((column) => column.name == item.column).first;
    return isarColumn.colorAsColor;
  }

  @override
  Widget build(BuildContext context) {
    var color = getColumnColor();
    return SizedBox(
      width: cardWidth,
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
                left: BorderSide(color: color, width: 6),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, openEditCard(item, color));
                      },
                      child: Text(
                        "[${item.id}] ${item.text}",
                        overflow: TextOverflow.clip,
                        style: const TextStyle(fontSize: 20),
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
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            getFormatedDate(item.dueDate!),
                            style: const TextStyle(fontSize: 16),
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
                    GestureDetector(
                      onTap: () async {
                        var nav = Navigator.of(context);
                        await Provider.of<AppState>(context, listen: false)
                            .setBoard(item);
                        nav.push(openNewBoard(item));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Align(
                          alignment: Alignment.center,
                          child: BoardPreview(
                            item: item,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
