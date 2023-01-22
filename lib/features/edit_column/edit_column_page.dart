import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/models/isar_models/tb_item.dart';
import 'package:taskboard/app_state.dart';
import 'package:taskboard/features/shared/dialog_box.dart';
import 'package:taskboard/features/shared/textfield.dart';

class EditColumnPage extends StatefulWidget {
  const EditColumnPage({super.key, required this.index, required this.item});

  final TBItem item;
  final int index;

  @override
  State<EditColumnPage> createState() => _EditColumnPageState();
}

class _EditColumnPageState extends State<EditColumnPage> {
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
                for (int i = 0; i < columnColors.length; i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = columnColors[i];
                      });
                    },
                    child: (selectedColor != columnColors[i])
                        ? CircleAvatar(
                            backgroundColor: columnColors[i], radius: 16)
                        : Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    columnColors[i].withOpacity(0.4),
                                radius: 16,
                              ),
                              CircleAvatar(
                                backgroundColor: columnColors[i],
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
