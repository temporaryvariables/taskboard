import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  const EditButton(
      {super.key,
      required this.onPressed,
      this.size = 16,
      this.icon = Icons.edit});

  final VoidCallback onPressed;
  final double size;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: IconButton(
        padding: const EdgeInsets.all(0),
        visualDensity: VisualDensity.compact,
        splashRadius: size * 0.8,
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: size,
        ),
      ),
    );
  }
}
