import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/models/isar_models/item.dart';
import 'package:taskboard/routes.dart';
import 'package:taskboard/state/app_state.dart';
import 'package:taskboard/views/board/card.dart';

enum Menu { addLeft, addRight, remove, edit }

class BoardColumn extends StatelessWidget {
  const BoardColumn({
    Key? key,
    required this.column,
    required this.itemsInColumn,
  }) : super(key: key);

  final String column;
  final List<Item> itemsInColumn;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
      width: cardWidth * 1.05,
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: DragTarget<Item>(
          onWillAccept: (data) {
            if (data == null) return false;
            // TODO: User validation, columns cant have the same name
            return data.column != column;
          },
          onAccept: (data) async {
            // what happens when dragged onto new column
            await Provider.of<AppState>(context, listen: false)
                .moveItemToColumn(data, data.column, column);
          },
          builder: (context, candidateData, rejectedData) {
            return Column(
              children: [
                PopupMenuButton(
                  onSelected: (Menu item) async {
                    var state = Provider.of<AppState>(context, listen: false);
                    var index = state.parentItem.boardColumns.indexOf(column);
                    switch (item) {
                      case Menu.addLeft:
                        await state.addColumn(index, "Backlog $index");
                        break;
                      case Menu.addRight:
                        await state.addColumn(index + 1, "Backlog $index");
                        break;
                      case Menu.remove:
                        await state.removeColumn(index);
                        break;
                      case Menu.edit:
                        Navigator.push(context, openEditColumn(index));
                        break;
                      default:
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem<Menu>(
                      value: Menu.addLeft,
                      child: Text('Add Left'),
                    ),
                    const PopupMenuItem<Menu>(
                      value: Menu.addRight,
                      child: Text('Add Right'),
                    ),
                    const PopupMenuItem<Menu>(
                      value: Menu.remove,
                      child: Text('Remove'),
                    ),
                    const PopupMenuItem<Menu>(
                      value: Menu.edit,
                      child: Text('Edit'),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    column,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const Divider(
                  indent: 5,
                  endIndent: 5,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: itemsInColumn.length,
                    itemBuilder: (context, index) {
                      var item = itemsInColumn[index];
                      return Draggable<Item>(
                        data: item,
                        feedback: BoardCard(item: item),
                        childWhenDragging: Opacity(
                          opacity: 0.5,
                          child: BoardCard(item: item),
                        ),
                        child: BoardCard(item: item),
                      );
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}