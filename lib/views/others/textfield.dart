import 'package:flutter/material.dart';
import 'package:taskboard/constants.dart';

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
      cursorColor: black,
      decoration: const InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: lightGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: black),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: accent,
          ),
        ),
      ),
    );
  }
}
