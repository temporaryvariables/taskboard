import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/state/app_state.dart';
import 'package:taskboard/views/board/column.dart';

class TaskboardColumns extends StatelessWidget {
  const TaskboardColumns({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Building columns");
    return Expanded(
      child: Consumer<AppState>(
        builder: (_, appState, __) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: appState.parentItem.boardColumns.length,
              itemBuilder: (context, index) {
                var column = appState.parentItem.boardColumns[index];
                var itemsInColumn = appState.parentItem.boardItems.toList();
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
                itemsInColumn.sort(
                  (a, b) => a.order.compareTo(b.order),
                );
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
