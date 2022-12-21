import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/state/app_state.dart';

class BoardBottomBar extends StatelessWidget {
  const BoardBottomBar({
    Key? key,
    required TextEditingController contextController,
    required FocusNode contextFocus,
  })  : _contextController = contextController,
        _contextFocus = contextFocus,
        super(key: key);

  final TextEditingController _contextController;
  final FocusNode _contextFocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _contextController,
              focusNode: _contextFocus,
              onSubmitted: (String text) {
                Provider.of<AppState>(context, listen: false).addItem(text);
                _contextController.clear();
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
              Provider.of<AppState>(context, listen: false)
                  .addItem(_contextController.text);
              _contextController.clear();
              _contextFocus.requestFocus();
            },
          ),
        ],
      ),
    );
  }
}
