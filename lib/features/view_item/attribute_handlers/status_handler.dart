import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/app_state.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/features/view_item/attribute_handlers/attribute_basic.dart';
import 'package:taskboard/models/isar_models/tb_column.dart';
import 'package:taskboard/models/isar_models/tb_item.dart';

class StatusHandler extends StatefulWidget {
  const StatusHandler({super.key, required this.item});

  final TBItem item;

  @override
  State<StatusHandler> createState() => _StatusHandlerState();
}

class _StatusHandlerState extends State<StatusHandler> {
  TBItem get item => widget.item;

  @override
  Widget build(BuildContext context) {
    return AttributeBasic(
      name: "Status",
      child: Consumer<AppState>(
        builder: (_, appState, __) {
          return Row(
            children: [
              for (TBColumn column in item.parentItem.value?.boardColumns ?? [])
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: OutlinedButton(
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(const Size(0, 0)),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.zero),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          (item.status == column.name) ? accent : primary),
                    ),
                    onPressed: () async {
                      await appState.moveItemToColumn(item, column.name);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        column.name,
                        style:
                            const TextStyle(color: black, fontSize: smallFont),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
