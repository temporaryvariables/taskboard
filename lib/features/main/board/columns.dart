import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/features/main/board/column.dart';
import 'package:taskboard/helper.dart';
import 'package:taskboard/models/isar_models/tb_column.dart';
import 'package:taskboard/models/isar_models/tb_item.dart';
import 'package:taskboard/routes.dart';
import 'package:taskboard/app_state.dart';
import 'package:taskboard/features/main/item_card.dart';

class TaskboardColumns extends StatelessWidget {
  const TaskboardColumns({
    Key? key,
  }) : super(key: key);

  void sortTBItems(List<TBItem> objects) {
    objects.sort((a, b) {
      if (a.priority == null && b.priority == null) {
        return b.order.compareTo(a.order);
      }
      if (a.priority == null) {
        return 1;
      }
      if (b.priority == null) {
        return -1;
      }
      if (a.priority != b.priority) {
        return b.priority!.compareTo(a.priority!);
      }
      return b.order.compareTo(a.order);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<AppState>(
        builder: (_, appState, __) {
          var isSmall = MediaQuery.of(context).size.width < minScreen;
          if (appState.currentItem.viewType == "List") {
            if (appState.currentItem.boardColumns.length == 1) {
              var columnColor = appState.currentItem.boardColumns.first.color;
              return Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Wrap(
                    children: [
                      for (TBItem item
                          in appState.currentItem.boardItems.toList())
                        TBItemCard(columnColor: columnColor, item: item)
                    ],
                  ),
                ),
              );
            } else {
              var items = appState.currentItem.boardItems.toList();
              var sortedItems = [];
              var columns = appState.currentItem.boardColumns;
              List<DropdownMenuItem<TBColumn>> dropDownColumns = [];
              for (var column in columns) {
                sortedItems.addAll(
                    items.where((element) => column.name == element.column));
                dropDownColumns.add(
                    DropdownMenuItem(value: column, child: Text(column.name)));
              }

              if (columns.length == 2) {
                return Padding(
                  padding: isSmall
                      ? const EdgeInsets.all(4)
                      : const EdgeInsets.all(10),
                  child: ListView.builder(
                    itemCount: appState.currentItem.boardItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      var item = sortedItems[index];
                      var itemColumn = columns
                          .where(
                            (element) => element.name == item.column,
                          )
                          .first;
                      return GestureDetector(
                        onTap: () async {
                          await Provider.of<AppState>(context, listen: false)
                              .setBoard(item);
                        },
                        onDoubleTap: () {
                          Navigator.push(context, openEditItemDialogbox(item));
                        },
                        child: Card(
                          child: ClipPath(
                            clipper: ShapeBorderClipper(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                      color: itemColumn.color, width: 6),
                                ),
                              ),
                              child: Padding(
                                padding: isSmall
                                    ? const EdgeInsets.all(4)
                                    : const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: item.column == columns[1].name,
                                          activeColor: columns[1].color,
                                          onChanged: (value) {
                                            if (value != null) {
                                              if (value) {
                                                appState.moveItemToColumn(
                                                    item, columns[1].name);
                                              } else {
                                                appState.moveItemToColumn(
                                                    item, columns[0].name);
                                              }
                                            }
                                          },
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.itemDisplayString,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                              if (!isSmall)
                                                Row(
                                                  children: [
                                                    if (item.dueDate != null)
                                                      Text(
                                                        "Due Date: ${getFormatedDate(item.dueDate)}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    if (item.dueDate != null &&
                                                        item.priority != null)
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                    if (item.priority != null)
                                                      Text(
                                                        "Priority: ${item.priority.toString()}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: appState.currentItem.boardItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = sortedItems[index];
                    var itemColumn = columns
                        .where(
                          (element) => element.name == item.column,
                        )
                        .first;
                    return GestureDetector(
                      onTap: () async {
                        await Provider.of<AppState>(context, listen: false)
                            .setBoard(item);
                      },
                      onDoubleTap: () {
                        Navigator.push(context, openEditItemDialogbox(item));
                      },
                      child: Card(
                        child: ClipPath(
                          clipper: ShapeBorderClipper(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                    color: itemColumn.color, width: 6),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.itemDisplayString,
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                            Row(
                                              children: [
                                                if (item.dueDate != null)
                                                  Text(
                                                    "Due Date: ${getFormatedDate(item.dueDate)}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 12),
                                                  ),
                                                if (item.dueDate != null &&
                                                    item.priority != null)
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                if (item.priority != null)
                                                  Text(
                                                    "Priority: ${item.priority.toString()}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 12),
                                                  ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      DropdownButton<TBColumn>(
                                        isDense: true,
                                        value: itemColumn,
                                        items: dropDownColumns,
                                        onChanged: (value) {
                                          if (value != null) {
                                            appState.moveItemToColumn(
                                                item, value.name);
                                          }
                                        },
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }
          return Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: appState.currentItem.boardColumns.length,
              itemBuilder: (context, index) {
                var column = appState.currentItem.boardColumns[index];
                var itemsInColumn = appState.currentItem.boardItems.toList();
                if (appState.cliController.text.isNotEmpty &&
                    !appState.cliController.text.startsWith("\\")) {
                  itemsInColumn = itemsInColumn
                      .where((element) =>
                          element.text.contains(appState.cliController.text))
                      .toList();
                }
                itemsInColumn = itemsInColumn
                    .where((element) => element.column == column.name)
                    .toList();
                sortTBItems(itemsInColumn);
                // itemsInColumn.sort(
                //   (a, b) => a.order.compareTo(b.order),
                // );
                return TaskboardColumn(
                    column: column, itemsInColumn: itemsInColumn);
              },
            ),
          );
        },
      ),
    );
  }
}
