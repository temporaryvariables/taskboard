import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/models/isar_models/tb_item.dart';
import 'package:taskboard/state/app_state.dart';
import 'package:taskboard/views/board/edit_card.dart';

const List<Color> colors = [
  Color(0xFFF44336), // red
  Color(0xFFE91E63), // pink
  Color(0xFF9C27B0), // purple
  Color(0xFF673AB7), // deep purple
  Color(0xFF3F51B5), // indigo
  Color(0xFF2196F3), // blue
  Color(0xFF03A9F4), // light blue
  Color(0xFF00BCD4), // cyan
  Color(0xFF009688), // teal
  Color(0xFF4CAF50), // green
  Color(0xFF8BC34A), // light green
  Color(0xFFCDDC39), // lime
  Color(0xFFFFEB3B), // yellow
  Color(0xFFFFC107), // amber
  Color(0xFFFF9800), // orange
  Color(0xFFFF5722), // deep orange
  Color(0xFF795548), // brown
  Color(0xFF9E9E9E), // grey
  Color(0xFF607D8B), // blue grey
  Color(0xFF000000), // black
  Color(0xFFFFFFFF) // white
];

class EditTaskboardColumn extends StatefulWidget {
  const EditTaskboardColumn(
      {super.key, required this.index, required this.item});

  final TBItem item;
  final int index;

  @override
  State<EditTaskboardColumn> createState() => _EditTaskboardColumnState();
}

class _EditTaskboardColumnState extends State<EditTaskboardColumn> {
  late String selectedColor;
  TextEditingController columnName = TextEditingController();

  @override
  void initState() {
    super.initState();
    columnName.text = widget.item.boardColumns[widget.index].name;
    selectedColor = widget.item.boardColumns[widget.index].color;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 500,
        child: Card(
          elevation: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Editing ${columnName.text}",
                        style: const TextStyle(fontSize: 18)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Column Name", style: TextStyle(fontSize: 16)),
                    const SizedBox(
                      height: 2,
                    ),
                    BasicTextfield(
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
                                selectedColor = colors[i].value.toString();
                              });
                            },
                            child: (selectedColor != colors[i].value.toString())
                                ? CircleAvatar(
                                    backgroundColor: colors[i], radius: 16)
                                : Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            colors[i].withOpacity(0.4),
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
                          child: const Text("Cancel",
                              style: TextStyle(fontSize: 16)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        MaterialButton(
                          child: const Text("Save",
                              style: TextStyle(fontSize: 16)),
                          onPressed: () {
                            var item = widget.item;
                            var oldValue = item.boardColumns[widget.index].name;
                            var newValue = columnName.text;
                            item.boardColumns[widget.index].name = newValue;
                            item.boardColumns[widget.index].color =
                                selectedColor;
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
            ],
          ),
        ),
      ),
    );
  }
}
