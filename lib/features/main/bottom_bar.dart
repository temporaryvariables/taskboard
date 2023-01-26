import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/models/isar_models/tb_item.dart';
import 'package:taskboard/app_state.dart';

class TaskboardBottomBar extends StatelessWidget {
  const TaskboardBottomBar({
    Key? key,
    required FocusNode contextFocus,
  })  : _contextFocus = contextFocus,
        super(key: key);

  final FocusNode _contextFocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Consumer<AppState>(
        builder: (_, appState, __) {
          return TextField(
            autofocus: true,
            controller: appState.cliController,
            focusNode: _contextFocus,
            onSubmitted: (String text) async {
              _cliParser(text, appState, context);
            },
            style: const TextStyle(fontSize: 18),
            cursorColor: black,
            cursorWidth: 10,
            decoration: const InputDecoration(
              isDense: true,
              prefixIcon: Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
              contentPadding: EdgeInsets.all(0),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primary),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primary),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primary),
              ),
            ),
          );
        },
      ),
    );
  }

  void _cliParser(String text, AppState value, BuildContext context) async {
    var currentState = value;
    if (text.startsWith("\\a")) {
      var itemText = text.replaceFirst("\\a", "").trim();
      currentState.addItemWithText(itemText);
    } else if (text.startsWith("\\r")) {
      var itemIdString = text.replaceFirst("\\r", "").trim();
      var itemId = int.tryParse(itemIdString);
      if (itemId != null) {
        TBItem? itemToDelete = await currentState.getItemFromId(itemId);
        if (itemToDelete != null) {
          currentState.deleteItemRecursivily(itemToDelete);
        }
      }
    } else if (text.startsWith("\\e")) {
      var itemIdAndText = text.replaceFirst("\\e", "").trim();
      var itemId = int.tryParse(itemIdAndText.split(" ").first);
      var itemText = itemIdAndText.replaceFirst(itemId.toString(), "").trim();
      if (itemId != null) {
        await currentState.editItemText(itemId, itemText);
      }
    } else if (text.startsWith("\\m")) {
      var itemIdAndText = text.replaceFirst("\\m", "").trim();
      var itemId = int.tryParse(itemIdAndText.split(" ").first);
      var itemText = itemIdAndText.replaceFirst(itemId.toString(), "").trim();
      if (itemId != null) {
        await currentState.moveItemToColumnFromId(itemId, itemText);
      }
    } else if (text.startsWith("\\o")) {
      var itemIdString = text.replaceFirst("\\o", "").trim();
      var itemId = int.tryParse(itemIdString);
      if (itemId != null) {
        TBItem? itemToDelete = await currentState.getItemFromId(itemId);
        if (itemToDelete != null) {
          currentState.setBoard(itemToDelete);
        }
      }
    } else if (text.startsWith("\\b")) {
      currentState.setBoard(currentState.currentItem.parentItem.value!);
      Navigator.pop(context);
    }
    value.cliController.clear();
    _contextFocus.requestFocus();
  }
}
