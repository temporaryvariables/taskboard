import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/models/isar_models/tb_column.dart';
import 'package:taskboard/routes.dart';
import 'package:taskboard/state/app_state.dart';

class TaskBoardColumnHeader extends StatelessWidget {
  const TaskBoardColumnHeader({
    Key? key,
    required this.columnName,
    required this.isRemoveEnabled,
  }) : super(key: key);

  final String columnName;
  final bool isRemoveEnabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              var state = Provider.of<AppState>(context, listen: false);
              var index =
                  state.currentItem.boardColumnsAsStrings.indexOf(columnName);
              switch (item) {
                case Menu.addLeft:
                  var isarColumn = TBColumn();
                  await state.addColumn(index, isarColumn);
                  break;
                case Menu.addRight:
                  var isarColumn = TBColumn();
                  await state.addColumn(index + 1, isarColumn);
                  break;
                case Menu.edit:
                  Navigator.push(context,
                      openEditColumnDialogbox(index, state.currentItem));
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
                enabled: isRemoveEnabled,
                value: Menu.remove,
                child: const Text('Remove'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
