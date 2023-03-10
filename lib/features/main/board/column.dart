import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/features/main/board/item_card.dart';
import 'package:taskboard/models/isar_models/tb_column.dart';
import 'package:taskboard/models/isar_models/tb_item.dart';
import 'package:taskboard/app_state.dart';
import 'package:taskboard/features/shared/column_menu.dart';

class TaskboardColumn extends StatelessWidget {
  const TaskboardColumn({
    Key? key,
    required this.column,
    required this.itemsInColumn,
  }) : super(key: key);

  final TBColumn column;
  final List<TBItem> itemsInColumn;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth * 1.05,
      decoration: BoxDecoration(
        border: Border.all(
          color: lightGray,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: DragTarget<TBItem>(
          onWillAccept: (data) {
            if (data == null) return false;
            return data.status != column.name;
          },
          onAccept: (data) async {
            await Provider.of<AppState>(context, listen: false)
                .moveItemToColumn(data, column.name);
          },
          builder: (context, candidateData, rejectedData) {
            return Column(
              children: [
                TaskBoardColumnHeader(
                  columnName: column.name,
                  isRemoveEnabled: itemsInColumn.isEmpty,
                ),
                const Divider(
                  height: 0,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: itemsInColumn.length,
                    itemBuilder: (context, index) {
                      var item = itemsInColumn[index];
                      var columnColor = column.color;
                      var itemCard = TaskboardItemCard(
                          columnColor: columnColor, item: item);
                      return Draggable<TBItem>(
                        data: item,
                        feedback: itemCard,
                        childWhenDragging: Opacity(
                          opacity: 0.5,
                          child: itemCard,
                        ),
                        child: itemCard,
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
