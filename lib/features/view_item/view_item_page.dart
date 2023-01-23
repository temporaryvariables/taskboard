import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/app_state.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/features/view_item/view_item_title.dart';
import 'package:taskboard/features/view_item/view_item_top_bar.dart';
import 'package:taskboard/helper.dart';
import 'package:taskboard/models/isar_models/tb_item.dart';
import 'package:taskboard/routes.dart';

class ViewItemPage extends StatefulWidget {
  const ViewItemPage({super.key, required this.item});

  final TBItem item;

  @override
  State<ViewItemPage> createState() => _ViewItemPageState();
}

class _ViewItemPageState extends State<ViewItemPage> {
  Map<String, bool> showEdit = {};
  TBItem get item => widget.item;

  @override
  void initState() {
    super.initState();
  }

  var editIcon = const Icon(
    Icons.edit,
    color: enabledBlack,
    size: 14,
  );

  TableRow _tableRow(String key, String value, void Function()? onEdit) {
    return TableRow(
      children: <Widget>[
        TableCell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text(key),
          ),
        ),
        TableCell(
          child: InkWell(
            onTap: onEdit,
            onHover: (value) {
              setState(() {
                showEdit[key] = value;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Text(value),
                  const SizedBox(
                    width: 8,
                  ),
                  if (onEdit != null &&
                      showEdit[key] != null &&
                      showEdit[key] == true)
                    editIcon,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  TableRow _tableRowPriority(double? priority, void Function(int)? onEdit) {
    return TableRow(
      children: <Widget>[
        const TableCell(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Text("Priority"),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: (item.priority != null)
                ? Row(
                    children: [
                      for (var i = 0; i < 5; i++)
                        GestureDetector(
                          onTap: () {
                            if (onEdit != null) {
                              onEdit(i + 1);
                            }
                          },
                          child: Icon(
                            Icons.flag,
                            color: (priority! > i) ? accent : disabledGray,
                            size: 16,
                          ),
                        ),
                    ],
                  )
                : const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 4,
                    ),
                    child: Text("NA"),
                  ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ViewItemTopBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: 600,
            child: Consumer<AppState>(
              builder: (context, value, child) {
                return Column(
                  children: [
                    ViewItemTitle(
                      item: item,
                      showEdit: showEdit,
                      editIcon: editIcon,
                      onHover: (value) {
                        setState(() {
                          showEdit["title"] = value;
                        });
                      },
                      onEdit: () {},
                    ),
                    Table(
                      children: <TableRow>[
                        _tableRow(
                          "Status",
                          item.status.toString(),
                          () {},
                        ),
                        _tableRowPriority(item.priority, (val) {
                          var i = item;
                          i.priority = val.toDouble();
                          value.addItem(i);
                        }),
                        if (item.endDate == null)
                          _tableRow(
                            "Due Date",
                            item.dueDate != null
                                ? getFormatedDate(item.dueDate!)
                                : "NA",
                            () {
                              Navigator.push(context, editDueDate(item));
                            },
                          ),
                        if (item.endDate != null)
                          _tableRow(
                            "Timeline",
                            item.dueDate != null
                                ? "${getFormatedDate(item.dueDate!)} - ${getFormatedDate(item.endDate!)}"
                                : "NA",
                            () {
                              Navigator.push(context, editDueDate(item));
                            },
                          ),
                        _tableRow(
                          "Labels",
                          item.labels.toString(),
                          () {},
                        ),
                        _tableRow(
                          "Parent Item",
                          item.parentItem.value!.itemIdentifier.toString(),
                          () {},
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
