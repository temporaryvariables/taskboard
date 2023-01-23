import 'package:flutter/material.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/helper.dart';
import 'package:taskboard/models/isar_models/tb_item.dart';

class ViewItemTitle extends StatelessWidget {
  const ViewItemTitle(
      {Key? key,
      required this.item,
      required this.showEdit,
      required this.editIcon,
      required this.onHover,
      required this.onEdit})
      : super(key: key);

  final TBItem item;
  final Map<String, bool> showEdit;
  final Icon editIcon;
  final void Function(bool) onHover;
  final void Function() onEdit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onEdit,
      onHover: onHover,
      child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  if (showEdit["title"] != null && showEdit["title"] == true)
                    editIcon,
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Created: ${getFormatedDate(item.createdDate)}",
                style: const TextStyle(
                  color: disabledGray,
                  fontSize: 12,
                ),
              ),
              Text(
                "Last Update: ${getFormatedDate(item.lastUpdated)}",
                style: const TextStyle(
                  color: disabledGray,
                  fontSize: 12,
                ),
              ),
            ],
          )),
    );
  }
}
