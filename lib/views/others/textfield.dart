import 'package:flutter/material.dart';

class TBTextfield extends StatelessWidget {
  const TBTextfield({Key? key, this.textController, this.readOnly = false})
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
