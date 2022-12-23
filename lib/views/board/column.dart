import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/models/isar_models/tb_column.dart';
import 'package:taskboard/models/isar_models/tb_item.dart';
import 'package:taskboard/state/app_state.dart';
import 'package:taskboard/views/board/card.dart';
import 'package:taskboard/views/helper_widgets/column_menu.dart';

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
      decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: DragTarget<TBItem>(
          onWillAccept: (data) {
            if (data == null) return false;
            return data.column != column.name;
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
                      var columnColor = Color(int.parse(column.color));
                      var itemCard =
                          TaskboardCard(columnColor: columnColor, item: item);
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
