import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/app_state.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/features/view_item/attribute_handlers/title_handler.dart';
import 'package:taskboard/features/view_item/view_item_top_bar.dart';
import 'package:taskboard/helper.dart';
import 'package:taskboard/models/isar_models/tb_column.dart';
import 'package:taskboard/models/isar_models/tb_item.dart';
import 'package:taskboard/routes.dart';

class ViewItemPage extends StatefulWidget {
  const ViewItemPage({super.key, required this.item});

  final TBItem item;

  @override
  State<ViewItemPage> createState() => _ViewItemPageState();
}

class _ViewItemPageState extends State<ViewItemPage> {
  TextEditingController labelController = TextEditingController();
  bool isAddingLabel = false;
  Map<String, bool> showEdit = {};
  TBItem get item => widget.item;
  late Future<List<TBItem>> possibleParents;

  @override
  void initState() {
    super.initState();
    possibleParents = Provider.of<AppState>(context, listen: false)
        .getPossibleParentItems2(item);
  }

  var editIcon = const Icon(
    Icons.edit,
    color: enabledBlack,
    size: 14,
  );

  String _formatLabel(String label) {
    label = label.replaceAll(RegExp(r"[^a-zA-Z0-9]"), "");
    if (label[0] != "#") {
      label = "#$label";
    }
    return label;
  }

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

  TableRow _tableParentItemRow(String value, void Function()? onEdit) {
    return TableRow(
      children: <Widget>[
        const TableCell(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Text("Parent Item"),
          ),
        ),
        TableCell(
          child: InkWell(
              onTap: onEdit,
              onHover: (value) {
                setState(() {
                  showEdit["Parent Item"] = value;
                });
              },
              child: FutureBuilder(
                future: possibleParents,
                builder: (context, snapshot) {
                  if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: Text("Loading..."),
                    );
                  }
                  var allPossibleItems = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<TBItem>(
                        isDense: true,
                        elevation: 2,
                        focusColor: primary,
                        style: const TextStyle(fontSize: 14, color: black),
                        value: allPossibleItems![0],
                        items: allPossibleItems
                            .map(
                              (e) => DropdownMenuItem<TBItem>(
                                value: e,
                                child: Text(e!.itemIdentifier),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          Provider.of<AppState>(context, listen: false)
                              .moveItem(value!, item);
                        },
                      ),
                    ),
                  );
                },
              )),
        ),
      ],
    );
  }

  TableRow _tableStatusRow(String value, void Function()? onEdit) {
    return TableRow(
      children: <Widget>[
        const TableCell(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Text("Status"),
          ),
        ),
        TableCell(
          child: InkWell(
            onTap: onEdit,
            onHover: (value) {
              setState(() {
                showEdit["Status"] = value;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<TBColumn>(
                  isDense: true,
                  elevation: 2,
                  focusColor: primary,
                  style: const TextStyle(fontSize: 14, color: black),
                  value: item.parentItem.value?.boardColumns
                      .firstWhere((element) => element.name == item.status),
                  items: item.parentItem.value?.boardColumns
                      .map(
                        (e) => DropdownMenuItem<TBColumn>(
                          value: e,
                          child: Text(e.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    item.status = (value?.name ??
                        item.parentItem.value?.boardColumns[0].name)!;
                    Provider.of<AppState>(context, listen: false).addItem(item);
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  TableRow _tableLabelRow(void Function()? onEdit, AppState appState) {
    return TableRow(
      children: <Widget>[
        const TableCell(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Text("Labels"),
          ),
        ),
        TableCell(
          child: InkWell(
            onTap: onEdit,
            onHover: (value) {
              setState(() {
                showEdit["Labels"] = value;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.start,
                    spacing: 4,
                    runSpacing: 4,
                    children: [
                      for (int i = 0; i < item.labels.length; i++)
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Chip(
                            onDeleted: () {
                              item.labels = [
                                ...item.labels.sublist(0, i),
                                ...item.labels.sublist(i + 1)
                              ];
                              appState.addItem(item);
                            },
                            deleteIcon: const Icon(Icons.close, size: 12),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(2),
                              ),
                            ),
                            labelPadding: const EdgeInsets.only(left: 10),
                            padding: const EdgeInsets.only(bottom: 3),
                            visualDensity: VisualDensity.compact,
                            label: Text(
                              item.labels[i],
                            ),
                            backgroundColor: accent,
                            labelStyle: const TextStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                        ),
                      if (onEdit != null &&
                          showEdit["Labels"] != null &&
                          showEdit["Labels"] == true &&
                          isAddingLabel == false)
                        editIcon,
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      if (isAddingLabel == true)
                        Row(
                          children: [
                            SizedBox(
                              width: 200,
                              child: CupertinoTextField(
                                controller: labelController,
                                padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                if (labelController.text.isNotEmpty &&
                                    item.labels.contains(_formatLabel(
                                            labelController.text)) ==
                                        false) {
                                  var label =
                                      _formatLabel(labelController.text);
                                  item.labels = [label, ...item.labels];
                                  appState.addItem(item);
                                }
                                labelController.clear();
                              },
                              icon: const Icon(Icons.check),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  isAddingLabel = false;
                                });
                              },
                              icon: const Icon(Icons.close),
                            ),
                          ],
                        )
                    ],
                  ),
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
                    TitleHandler(
                      item: item,
                    ),
                    Table(
                      children: <TableRow>[
                        _tableStatusRow(
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
                        _tableLabelRow(() {
                          setState(() {
                            isAddingLabel = !isAddingLabel;
                          });
                        }, value),
                        _tableParentItemRow(
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
