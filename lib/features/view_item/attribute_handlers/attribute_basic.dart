import 'package:flutter/material.dart';
import 'package:taskboard/constants.dart';

class AttributeBasic extends StatelessWidget {
  const AttributeBasic({super.key, required this.name, required this.child});

  final String name;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 160,
          child: Text(
            name,
            style: const TextStyle(
              fontSize: mediumFont,
            ),
          ),
        ),
        child,
      ],
    );
  }
}
