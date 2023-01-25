import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/app_state.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/features/view_item/attribute_handlers/attribute_basic.dart';
import 'package:taskboard/features/view_item/attribute_handlers/edit_button.dart';
import 'package:taskboard/models/isar_models/tb_item.dart';
import 'package:taskboard/routes.dart';

class ParentHandler extends StatefulWidget {
  const ParentHandler({super.key, required this.item});

  final TBItem item;

  @override
  State<ParentHandler> createState() => _ParentHandlerState();
}

class _ParentHandlerState extends State<ParentHandler> {
  TBItem get item => widget.item;

  @override
  Widget build(BuildContext context) {
    return AttributeBasic(
      name: "Parent Item",
      child: Row(
        children: [
          Consumer<AppState>(builder: (context, value, child) {
            return Text(
              item.parentItem.value?.itemIdentifier ?? "None",
              style: const TextStyle(
                fontSize: mediumFont,
              ),
            );
          }),
          EditButton(
            onPressed: () {
              Navigator.push(context, editParentItem(item));
            },
          )
        ],
      ),
    );
  }
}
