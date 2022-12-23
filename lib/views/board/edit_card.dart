import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/models/isar_models/item.dart';
import 'package:taskboard/state/app_state.dart';

class EditCard extends StatefulWidget {
  const EditCard({super.key, required this.item, required this.color});

  final Item item;
  final Color color;

  @override
  State<EditCard> createState() => _EditCardState();
}

class _EditCardState extends State<EditCard> {
  TextEditingController textController = TextEditingController();
  TextEditingController boardName = TextEditingController();
  DateTime selectedDate = DateTime.now();
  double priority = 2.5;

  @override
  void initState() {
    super.initState();
    textController.text = widget.item.text;
    boardName.text = widget.item.boardName ?? "";
    priority = widget.item.priority ?? 2.5;
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 400,
        width: 500,
        child: Card(
          elevation: 0,
          child: Column(
            children: [
              TextField(
                controller: textController,
                style: const TextStyle(fontSize: 24),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Colors.black.withOpacity(0.4)),
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
              ),
              TextField(
                controller: boardName,
                style: const TextStyle(fontSize: 24),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Colors.black.withOpacity(0.4)),
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
              ),
              Row(
                children: [
                  Text(selectedDate.toString()),
                  IconButton(
                      onPressed: () => _selectDate(context),
                      icon: const Icon(Icons.calendar_today))
                ],
              ),
              Text(priority.toStringAsFixed(1)),
              Slider(
                value: priority,
                max: 5,
                min: 0,
                onChanged: (double value) {
                  setState(() {
                    priority = value;
                  });
                },
              ),
              MaterialButton(
                child: const Text("Delete"),
                onPressed: () {
                  Provider.of<AppState>(context, listen: false)
                      .deleteItemRecursivily(widget.item);
                  Navigator.pop(context);
                },
              ),
              MaterialButton(
                child: const Text("Done"),
                onPressed: () {
                  var item = widget.item;
                  item.text = textController.text;
                  item.boardName = boardName.text;
                  item.dueDate = selectedDate;
                  item.priority = double.parse(priority.toStringAsFixed(1));
                  Provider.of<AppState>(context, listen: false).addItem(item);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
