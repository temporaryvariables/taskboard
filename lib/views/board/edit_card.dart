import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/helper.dart';
import 'package:taskboard/models/isar_models/item.dart';
import 'package:taskboard/state/app_state.dart';

class EditCard extends StatefulWidget {
  const EditCard({super.key, required this.item});

  final Item item;

  @override
  State<EditCard> createState() => _EditCardState();
}

class _EditCardState extends State<EditCard> {
  TextEditingController textController = TextEditingController();
  TextEditingController boardName = TextEditingController();
  TextEditingController dueDate = TextEditingController();
  DateTime selectedDate = DateTime.now();
  double? priority;

  @override
  void initState() {
    super.initState();
    textController.text = widget.item.text;
    boardName.text = widget.item.boardName ?? "";
    dueDate.text = "NA";
    if (widget.item.dueDate != null) {
      dueDate.text = getFormatedDate(widget.item.dueDate!);
    }
    priority = widget.item.priority;
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
        dueDate.text = getFormatedDate(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 500,
        child: Card(
          elevation: 1,
          borderOnForeground: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Editing ${widget.item.text}",
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
                    const Text("Text Content", style: TextStyle(fontSize: 16)),
                    const SizedBox(
                      height: 2,
                    ),
                    BasicTextfield(textController: textController),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Board Name", style: TextStyle(fontSize: 16)),
                    const SizedBox(
                      height: 2,
                    ),
                    BasicTextfield(
                      textController: boardName,
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
                          child: BasicTextfield(
                            readOnly: true,
                            textController: dueDate,
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
                              dueDate.text == "NA";
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
                        Text((priority ?? 0).toStringAsFixed(0),
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
                              thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 8.0),
                              overlayColor: Colors.red.withAlpha(32),
                              overlayShape: const RoundSliderOverlayShape(
                                  overlayRadius: 12.0),
                            ),
                            child: Slider(
                              value: priority ?? 0,
                              max: 5,
                              min: 0,
                              thumbColor: Colors.black,
                              activeColor: Colors.black,
                              inactiveColor: Colors.black,
                              divisions: 5,
                              onChanged: (double value) {
                                setState(() {
                                  priority = value;
                                });
                              },
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              priority = null;
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
                              style:
                                  TextStyle(color: Colors.red, fontSize: 16)),
                          onPressed: () {
                            Provider.of<AppState>(context, listen: false)
                                .deleteItemRecursivily(widget.item);
                            Navigator.pop(context);
                          },
                        ),
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
                            item.text = textController.text.isNotEmpty
                                ? textController.text
                                : item.text;
                            item.boardName = boardName.text.isNotEmpty
                                ? boardName.text
                                : item.boardName;
                            if (!dueDate.text.contains("NA")) {
                              item.dueDate = selectedDate;
                            }
                            if (priority != null) {
                              item.priority =
                                  double.parse(priority!.toStringAsFixed(1));
                            }
                            Provider.of<AppState>(context, listen: false)
                                .addItem(item);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BasicTextfield extends StatelessWidget {
  const BasicTextfield({Key? key, this.textController, this.readOnly = false})
      : super(key: key);

  final bool readOnly;
  final TextEditingController? textController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly,
      controller: textController,
      style: const TextStyle(fontSize: 18),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(width: 1, color: Colors.black.withOpacity(0.4)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.black),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
