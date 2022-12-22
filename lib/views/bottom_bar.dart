import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/models/isar_models/item.dart';
import 'package:taskboard/routes.dart';
import 'package:taskboard/state/app_state.dart';

class BoardBottomBar extends StatelessWidget {
  const BoardBottomBar({
    Key? key,
    required FocusNode contextFocus,
  })  : _contextFocus = contextFocus,
        super(key: key);

  final FocusNode _contextFocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Consumer<AppState>(
              builder: (context, value, child) {
                return TextField(
                  autofocus: true,
                  controller: value.cliController,
                  focusNode: _contextFocus,
                  onSubmitted: (String text) async {
                    var currentState = value;
                    if (text.startsWith("\\a")) {
                      var itemText = text.replaceFirst("\\a", "").trim();
                      currentState.addItemWithText(itemText);
                    } else if (text.startsWith("\\r")) {
                      var itemIdString = text.replaceFirst("\\r", "").trim();
                      var itemId = int.tryParse(itemIdString);
                      if (itemId != null) {
                        Item? itemToDelete =
                            await currentState.getItemFromId(itemId);
                        if (itemToDelete != null) {
                          currentState.deleteItemRecursivily(itemToDelete);
                        }
                      }
                    } else if (text.startsWith("\\e")) {
                      var itemIdAndText = text.replaceFirst("\\e", "").trim();
                      var itemId = int.tryParse(itemIdAndText.split(" ").first);
                      var itemText = itemIdAndText
                          .replaceFirst(itemId.toString(), "")
                          .trim();
                      if (itemId != null) {
                        await currentState.editItemText(itemId, itemText);
                      }
                    } else if (text.startsWith("\\m")) {
                      var itemIdAndText = text.replaceFirst("\\m", "").trim();
                      var itemId = int.tryParse(itemIdAndText.split(" ").first);
                      var itemText = itemIdAndText
                          .replaceFirst(itemId.toString(), "")
                          .trim();
                      if (itemId != null) {
                        await currentState.moveItemToColumnFromId(
                            itemId, itemText);
                      }
                    } else if (text.startsWith("\\o")) {
                      var nav = Navigator.of(context);
                      var itemIdString = text.replaceFirst("\\o", "").trim();
                      var itemId = int.tryParse(itemIdString);
                      if (itemId != null) {
                        Item? itemToDelete =
                            await currentState.getItemFromId(itemId);
                        if (itemToDelete != null) {
                          nav.push(openNewBoard(itemToDelete));
                        }
                      }
                    } else if (text.startsWith("\\b")) {
                      Navigator.pop(context);
                    }
                    value.cliController.clear();
                    _contextFocus.requestFocus();
                  },
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
                );
              },
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            color: Colors.black,
            splashColor: Colors.red,
            splashRadius: 20,
            onPressed: () {
              var currentState = Provider.of<AppState>(context, listen: false);
              currentState.addItemWithText(currentState.cliController.text);
              currentState.cliController.clear();
              _contextFocus.requestFocus();
            },
          ),
        ],
      ),
    );
  }
}
