import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/models/isar_models/item.dart';
import 'package:taskboard/state/app_state.dart';

List<Color> colors = [
  Colors.grey,
  Colors.blue,
  Colors.green,
  Colors.orange,
  Colors.purple
];

class EditColumn extends StatefulWidget {
  const EditColumn({super.key, required this.index, required this.item});

  final Item item;
  final int index;

  @override
  State<EditColumn> createState() => _EditColumnState();
}

class _EditColumnState extends State<EditColumn> {
  late String selectedColor;
  TextEditingController columnName = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    columnName.text = widget.item.boardColumns[widget.index].name;
    selectedColor = widget.item.boardColumns[widget.index].color;
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
                controller: columnName,
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
              Wrap(
                children: [
                  for (int i = 0; i < colors.length; i++)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColor = colors[i].value.toString();
                        });
                      },
                      child: (selectedColor != colors[i].value.toString())
                          ? CircleAvatar(backgroundColor: colors[i], radius: 20)
                          : CircleAvatar(
                              backgroundColor: colors[i],
                              radius: 10,
                            ),
                    )
                ],
              ),
              MaterialButton(
                child: const Text("Done"),
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
        ),
      ),
    );
  }
}
