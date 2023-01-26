import 'package:flutter/material.dart';

class AppBarIconButton extends StatelessWidget {
  const AppBarIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.size = 28,
    this.isDisabled = false,
  }) : super(key: key);

  final bool isDisabled;
  final VoidCallback onPressed;
  final IconData icon;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.all(0),
      visualDensity: VisualDensity.compact,
      onPressed: onPressed,
      icon: Icon(
        size: size,
        icon,
        color: (isDisabled) ? Theme.of(context).disabledColor : null,
      ),
    );
  }
}
