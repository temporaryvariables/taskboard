import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/helper.dart';
import 'package:taskboard/models/isar_models/tb_item.dart';
import 'package:taskboard/app_state.dart';
import 'package:taskboard/features/edit_item/calendar.dart';
import 'package:taskboard/features/shared/dialog_box.dart';
import 'package:taskboard/features/shared/textfield.dart';

class EditItemPage extends StatefulWidget {
  const EditItemPage({super.key, required this.item});

  final TBItem item;

  @override
  State<EditItemPage> createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  TextEditingController itemTextController = TextEditingController();
  TextEditingController itemDueDateController = TextEditingController();
  double? selectedPriority;
  List<bool> setPriority = [false, false, false, false, false];
  late Future<List<TBItem>> possibleParents;
  late TBItem selectedItem;

  TBItem get item => widget.item;

  @override
  void initState() {
    super.initState();
    itemTextController.text = item.text;
    itemDueDateController.text = "NA";
    if (item.dueDate != null) {
      itemDueDateController.text = getFormatedDate(item.dueDate!);
    }
    if (item.priority != null) {
      for (int j = 0; j < item.priority!.toInt(); j++) {
        setPriority[j] = true;
      }
    }
    selectedPriority = item.priority;
    possibleParents = Provider.of<AppState>(context, listen: false)
        .getPossibleParentItems2(item);
    selectedItem = item.parentItem.value!;
  }

  int getPriority() {
    return setPriority.where((element) => element).length;
  }

  @override
  Widget build(BuildContext context) {
    return DialogBox(
      title: "Editing Item ${item.text}",
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Text", style: TextStyle(fontSize: 16)),
            const SizedBox(
              height: 2,
            ),
            TBTextfield(textController: itemTextController),
            const SizedBox(
              height: 10,
            ),
            const Text("Priority", style: TextStyle(fontSize: 16)),
            const SizedBox(
              height: 2,
            ),
            Row(
              children: [
                for (int i = 0; i < setPriority.length; i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        setPriority = [false, false, false, false, false];
                        for (int j = 0; j < i + 1; j++) {
                          setPriority[j] = !setPriority[j];
                        }
                      });
                    },
                    child: Icon(
                      Icons.flag,
                      color: setPriority[i] ? accent : lightGray,
                    ),
                  ),
                const SizedBox(
                  width: 4,
                ),
                Text((getPriority()).toStringAsFixed(0),
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(
                  width: 6,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      setPriority = [false, false, false, false, false];
                    });
                  },
                  child: Icon(
                    Icons.refresh,
                    color: getPriority() == 0 ? disabledGray : enabledBlack,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Due Date",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            CalendarView(
              item: item,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Parent Item", style: TextStyle(fontSize: 16)),
            const SizedBox(
              height: 2,
            ),
            Text(
              "Current Parent Item: ${item.parentItem.value!.itemDisplayString}",
              style: const TextStyle(fontSize: 10),
            ),
            const SizedBox(
              height: 2,
            ),
            Container(
              constraints: const BoxConstraints(maxHeight: 200),
              child: FutureBuilder(
                future: possibleParents,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 0,
                          color: accent,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedItem = snapshot.data![index];
                                });
                              },
                              child: Row(
                                children: [
                                  if (selectedItem == snapshot.data![index])
                                    const Icon(
                                      Icons.check,
                                      size: 14,
                                    ),
                                  if (selectedItem != snapshot.data![index])
                                    const Icon(
                                      Icons.check,
                                      color: transparent,
                                      size: 14,
                                    ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(snapshot.data![index].itemDisplayString)
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Text("Loading...");
                  }
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  child: const Text(
                    "Delete",
                    style: TextStyle(
                      color: accent,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    Provider.of<AppState>(context, listen: false)
                        .deleteItemRecursivily(item);
                    Navigator.pop(context);
                  },
                ),
                MaterialButton(
                  child: const Text("Cancel", style: TextStyle(fontSize: 16)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                MaterialButton(
                  child: const Text("Save", style: TextStyle(fontSize: 16)),
                  onPressed: () async {
                    item.text = itemTextController.text.isNotEmpty
                        ? itemTextController.text
                        : item.text;
                    item.dueDate = Provider.of<AppState>(context, listen: false)
                        .selectedDate;

                    if (getPriority() == 0) {
                      item.priority = null;
                    } else {
                      item.priority = getPriority().toDouble();
                    }

                    if (selectedItem != item.parentItem.value!) {
                      Provider.of<AppState>(context, listen: false)
                          .moveItem(selectedItem, item);
                    }
                    Provider.of<AppState>(context, listen: false).addItem(item);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
