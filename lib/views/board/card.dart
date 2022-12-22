import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/models/isar_models/item.dart';
import 'package:taskboard/routes.dart';
import 'package:taskboard/state/app_state.dart';
import 'package:taskboard/views/board/preview.dart';

class BoardCard extends StatelessWidget {
  const BoardCard({Key? key, required this.item, required this.color})
      : super(key: key);

  final Item item;
  final Color color;

  String formatDate(DateTime date) {
    return "${date.month}/${date.day}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cardWidth,
      child: GestureDetector(
        onTap: () async {
          var nav = Navigator.of(context);
          await Provider.of<AppState>(context, listen: false).setBoard(item);
          nav.push(openNewBoard(item));
        },
        child: Card(
          elevation: 0,
          child: ClipPath(
            clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3))),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: color, width: 5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${item.id}. ${item.text}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            splashRadius: 15,
                            padding: const EdgeInsets.all(0),
                            onPressed: () {
                              Navigator.push(
                                  context, openEditCard(item, color));
                            },
                            icon: const Icon(
                              Icons.edit,
                              size: 16,
                            ),
                          )
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Due Date",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            formatDate(item.dueDate ?? DateTime.now()),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Priority",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            item.priority.toString(),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      if (item.boardItems.isNotEmpty)
                        Align(
                          alignment: Alignment.center,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: BoardPreview(
                              item: item,
                            ),
                          ),
                        ),
                      const SizedBox(
                        height: 12,
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
