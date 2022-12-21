import 'package:flutter/material.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/models/isar_models/item.dart';
import 'package:taskboard/routes.dart';
import 'package:taskboard/views/board/preview.dart';

class BoardCard extends StatelessWidget {
  const BoardCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item item;

  String formatDate(DateTime date) {
    return "${date.month}/${date.day}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cardWidth,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, openNewBoard(item));
        },
        child: Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 2,
              ),
              Text(
                item.content!,
                style: const TextStyle(fontSize: 16),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Created",
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    formatDate(item.createdDate),
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Updated",
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    formatDate(item.lastUpdated),
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              if (item.boardItems.isNotEmpty)
                Align(
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: BoardPreview(
                      item: item,
                    ),
                  ),
                ),
              const SizedBox(
                height: 12,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
