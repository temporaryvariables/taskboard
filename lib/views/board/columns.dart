import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/state/app_state.dart';
import 'package:taskboard/views/board/column.dart';

class BoardColumns extends StatelessWidget {
  const BoardColumns({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<AppState>(
        builder: (_, appState, __) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: appState.parentItem.boardColumns.length,
                  itemBuilder: (context, index) {
                    var column = appState.parentItem.boardColumns[index];
                    var itemsInColumn = appState.parentItem.boardItems.toList();
                    itemsInColumn = itemsInColumn
                        .where((element) => element.column == column)
                        .toList();
                    itemsInColumn.sort(
                      (a, b) => a.order.compareTo(b.order),
                    );
                    return BoardColumn(
                        column: column, itemsInColumn: itemsInColumn);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
