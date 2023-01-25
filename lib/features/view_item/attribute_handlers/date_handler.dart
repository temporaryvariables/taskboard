import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/app_state.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/features/view_item/attribute_handlers/attribute_basic.dart';
import 'package:taskboard/features/view_item/attribute_handlers/edit_button.dart';
import 'package:taskboard/helper.dart';
import 'package:taskboard/models/isar_models/tb_item.dart';
import 'package:taskboard/routes.dart';

class DateHandler extends StatefulWidget {
  const DateHandler({super.key, required this.item});

  final TBItem item;

  @override
  State<DateHandler> createState() => _DateHandlerState();
}

class _DateHandlerState extends State<DateHandler> {
  TBItem get item => widget.item;

  String getRangeOrDueDate() {
    if (item.dueDate != null && item.endDate != null) {
      return "${getFormatedDate(item.dueDate)} - ${getFormatedDate(item.endDate)}";
    } else if (item.dueDate != null) {
      return getFormatedDate(item.dueDate);
    } else if (item.endDate != null) {
      return getFormatedDate(item.endDate);
    } else {
      return "No Date";
    }
  }

  @override
  Widget build(BuildContext context) {
    return AttributeBasic(
      name: item.endDate == null ? "Due Date" : "Timeline",
      child: Row(
        children: [
          Consumer<AppState>(
            builder: (context, value, child) {
              return Text(
                getRangeOrDueDate(),
                style: const TextStyle(
                  fontSize: mediumFont,
                ),
              );
            },
          ),
          EditButton(
            size: 18,
            icon: Icons.calendar_today,
            onPressed: () {
              Navigator.push(context, editDueDate(item));
            },
          )
        ],
      ),
    );
  }
}
