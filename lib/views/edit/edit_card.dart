import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/helper.dart';
import 'package:taskboard/models/isar_models/tb_item.dart';
import 'package:taskboard/state/app_state.dart';
import 'package:taskboard/views/helper_widgets/dialog_box.dart';
import 'package:taskboard/views/helper_widgets/textfield.dart';

class EditTaskboardCard extends StatefulWidget {
  const EditTaskboardCard({super.key, required this.item});

  final TBItem item;

  @override
  State<EditTaskboardCard> createState() => _EditTaskboardCardState();
}

class _EditTaskboardCardState extends State<EditTaskboardCard> {
  TextEditingController itemTextController = TextEditingController();
  TextEditingController itemBoardNameController = TextEditingController();
  TextEditingController itemDueDateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  double? selectedPriority;

  TBItem get item => widget.item;

  @override
  void initState() {
    super.initState();
    itemTextController.text = item.text;
    itemBoardNameController.text = item.boardName ?? "";
    itemDueDateController.text = "NA";
    if (item.dueDate != null) {
      itemDueDateController.text = getFormatedDate(item.dueDate!);
    }
    selectedPriority = item.priority;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        itemDueDateController.text = getFormatedDate(picked);
      });
    }
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
            const Text("Text Content", style: TextStyle(fontSize: 16)),
            const SizedBox(
              height: 2,
            ),
            TBTextfield(textController: itemTextController),
            const SizedBox(
              height: 10,
            ),
            const Text("Board Name", style: TextStyle(fontSize: 16)),
            const SizedBox(
              height: 2,
            ),
            TBTextfield(
              textController: itemBoardNameController,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Due Date", style: TextStyle(fontSize: 16)),
            const SizedBox(
              height: 2,
            ),
            Row(
              children: [
                Expanded(
                  child: TBTextfield(
                    readOnly: true,
                    textController: itemDueDateController,
                  ),
                ),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 10, right: 5),
                    child: Icon(Icons.calendar_today),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      itemDueDateController.text == "NA";
                    });
                  },
                  child: const Icon(Icons.refresh, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Priority", style: TextStyle(fontSize: 16)),
            const SizedBox(
              height: 2,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 4,
                ),
                Text((selectedPriority ?? 0).toStringAsFixed(0),
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(
                  width: 6,
                ),
                SizedBox(
                  width: 200,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackShape: const RectangularSliderTrackShape(),
                      trackHeight: 4.0,
                      thumbShape:
                          const RoundSliderThumbShape(enabledThumbRadius: 8.0),
                      overlayColor: Colors.red.withAlpha(32),
                      overlayShape:
                          const RoundSliderOverlayShape(overlayRadius: 12.0),
                    ),
                    child: Slider(
                      value: selectedPriority ?? 0,
                      max: 5,
                      min: 0,
                      thumbColor: Colors.black,
                      activeColor: Colors.black,
                      inactiveColor: Colors.black,
                      divisions: 5,
                      onChanged: (double value) {
                        setState(() {
                          selectedPriority = value;
                        });
                      },
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPriority = null;
                    });
                  },
                  child: const Icon(
                    Icons.refresh,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  child: const Text("Delete",
                      style: TextStyle(color: Colors.red, fontSize: 16)),
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
                  onPressed: () {
                    item.text = itemTextController.text.isNotEmpty
                        ? itemTextController.text
                        : item.text;
                    item.boardName = itemBoardNameController.text.isNotEmpty
                        ? itemBoardNameController.text
                        : item.boardName;
                    if (!itemDueDateController.text.contains("NA")) {
                      item.dueDate = selectedDate;
                    }
                    if (selectedPriority != null) {
                      item.priority =
                          double.parse(selectedPriority!.toStringAsFixed(1));
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
