import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/app_state.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/features/view_item/attribute_handlers/attribute_basic.dart';
import 'package:taskboard/models/isar_models/tb_item.dart';

class PriorityHandler extends StatefulWidget {
  const PriorityHandler({super.key, required this.item});

  final TBItem item;

  @override
  State<PriorityHandler> createState() => _PriorityHandlerState();
}

class _PriorityHandlerState extends State<PriorityHandler> {
  TBItem get item => widget.item;

  @override
  Widget build(BuildContext context) {
    return AttributeBasic(
      name: "Priority",
      child: Consumer<AppState>(
        builder: (_, appState, __) {
          return Row(
            children: [
              for (var i = 0; i < 5; i++)
                GestureDetector(
                  onTap: () async {
                    await appState.editPriority(item, (i + 1).toDouble());
                  },
                  child: Icon(
                    Icons.flag,
                    color: ((item.priority ?? 0) > i) ? accent : disabledGray,
                    size: 20,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
