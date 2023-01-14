import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/models/isar_models/tb_item.dart';
import 'package:taskboard/state/app_state.dart';
import 'package:taskboard/views/others/dialog_box.dart';
import 'package:taskboard/views/others/textfield.dart';

class EditTaskboardColumn extends StatefulWidget {
  const EditTaskboardColumn(
      {super.key, required this.index, required this.item});

  final TBItem item;
  final int index;

  @override
  State<EditTaskboardColumn> createState() => _EditTaskboardColumnState();
}

class _EditTaskboardColumnState extends State<EditTaskboardColumn> {
  late Color selectedColor;
  TextEditingController columnName = TextEditingController();

  @override
  void initState() {
    super.initState();
    columnName.text = widget.item.boardColumns[widget.index].name;
    selectedColor = widget.item.boardColumns[widget.index].color;
  }

  @override
  Widget build(BuildContext context) {
    return DialogBox(
      title: "Editing Column",
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Column Name", style: TextStyle(fontSize: 16)),
            const SizedBox(
              height: 2,
            ),
            TBTextfield(
              textController: columnName,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Column Color", style: TextStyle(fontSize: 16)),
            const SizedBox(
              height: 2,
            ),
            Wrap(
              spacing: 5,
              runSpacing: 5,
              children: [
                for (int i = 0; i < colors.length; i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = colors[i];
                      });
                    },
                    child: (selectedColor != colors[i])
                        ? CircleAvatar(backgroundColor: colors[i], radius: 16)
                        : Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: colors[i].withOpacity(0.4),
                                radius: 16,
                              ),
                              CircleAvatar(
                                backgroundColor: colors[i],
                                radius: 12,
                              ),
                            ],
                          ),
                  )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                MaterialButton(
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    var item = widget.item;
                    var oldValue = item.boardColumns[widget.index].name;
                    var newValue = columnName.text;
                    item.boardColumns[widget.index].name = newValue;
                    item.boardColumns[widget.index].color = selectedColor;
                    Provider.of<AppState>(context, listen: false)
                        .addItemWithColumns(item, oldValue, newValue);
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
