import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/models/isar_models/isar_column.dart';
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

  final IsarColumn column;
  final List<Item> itemsInColumn;

  String get columnName => column.name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth * 1.05,
      decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: DragTarget<Item>(
          onWillAccept: (data) {
            if (data == null) return false;
            return data.column != columnName;
          },
          onAccept: (data) async {
            await Provider.of<AppState>(context, listen: false)
                .moveItemToColumn(data, columnName);
          },
          builder: (context, candidateData, rejectedData) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        columnName,
                        style: const TextStyle(fontSize: 18),
                      ),
                      PopupMenuButton(
                        iconSize: 20,
                        splashRadius: 16,
                        padding: const EdgeInsets.all(0),
                        onSelected: (Menu item) async {
                          var state =
                              Provider.of<AppState>(context, listen: false);
                          var index = state.parentItem.boardColumnsAsStrings
                              .indexOf(columnName);
                          switch (item) {
                            case Menu.addLeft:
                              var isarColumn = IsarColumn();
                              await state.addColumn(index, isarColumn);
                              break;
                            case Menu.addRight:
                              var isarColumn = IsarColumn();
                              await state.addColumn(index + 1, isarColumn);
                              break;
                            case Menu.edit:
                              Navigator.push(context,
                                  openEditColumn(index, state.parentItem));
                              break;
                            case Menu.remove:
                              await state.removeColumn(index);
                              break;
                            default:
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem<Menu>(
                            height: 25,
                            value: Menu.addLeft,
                            child: Text('Add Left'),
                          ),
                          const PopupMenuItem<Menu>(
                            height: 25,
                            value: Menu.addRight,
                            child: Text('Add Right'),
                          ),
                          const PopupMenuItem<Menu>(
                            height: 25,
                            value: Menu.edit,
                            child: Text('Edit'),
                          ),
                          PopupMenuItem<Menu>(
                            height: 25,
                            enabled: itemsInColumn.isEmpty,
                            value: Menu.remove,
                            child: const Text('Remove'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 0,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: itemsInColumn.length,
                    itemBuilder: (context, index) {
                      var item = itemsInColumn[index];
                      var card = BoardCard(column: column, item: item);
                      return Draggable<Item>(
                        data: item,
                        feedback: card,
                        childWhenDragging: Opacity(
                          opacity: 0.5,
                          child: card,
                        ),
                        child: card,
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
