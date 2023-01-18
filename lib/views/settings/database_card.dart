import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taskboard/constants.dart';

class DatabaseCard extends StatelessWidget {
  const DatabaseCard({
    super.key,
    required this.path,
    this.onDelete,
    this.onOpen,
    this.onDefault,
    this.isDefault = false,
  });

  final String path;
  final bool isDefault;
  final void Function()? onDelete;
  final void Function()? onOpen;
  final void Function()? onDefault;

  @override
  Widget build(BuildContext context) {
    File pathFile = File(path);
    return Card(
      elevation: 0,
      color: backgroundTodayWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          children: [
            const Icon(Icons.folder),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pathFile.absolute.path
                        .split('/')
                        .last
                        .replaceFirst(".isar", ""),
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    pathFile.absolute.path,
                    softWrap: true,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            if (onDefault != null)
              IconButton(
                splashRadius: 20,
                onPressed: onDefault,
                icon: Icon(
                  Icons.star,
                  color: (isDefault) ? Colors.yellow : Colors.grey,
                ),
              ),
            if (onOpen != null)
              IconButton(
                splashRadius: 20,
                onPressed: onOpen,
                icon: const Icon(Icons.open_in_browser),
              ),
            if (onDelete != null)
              IconButton(
                splashRadius: 20,
                onPressed: onDelete,
                icon: const Icon(Icons.delete),
              ),
          ],
        ),
      ),
    );
  }
}
