import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/app_state.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/features/shared/textfield.dart';
import 'package:taskboard/features/view_item/attribute_handlers/edit_button.dart';
import 'package:taskboard/helper.dart';
import 'package:taskboard/models/isar_models/tb_item.dart';

class TitleHandler extends StatefulWidget {
  const TitleHandler({super.key, required this.item});

  final TBItem item;

  @override
  State<TitleHandler> createState() => _TitleHandlerState();
}

class _TitleHandlerState extends State<TitleHandler> {
  TextEditingController titleNameController = TextEditingController();
  TBItem get item => widget.item;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    titleNameController.text = item.title;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isEditing)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: xxLargeFont,
                ),
              ),
              EditButton(
                size: 20,
                onPressed: () {
                  setState(() {
                    isEditing = !isEditing;
                  });
                },
              ),
            ],
          )
        else
          Row(
            children: [
              Expanded(
                child: TBTextfield(
                  textController: titleNameController,
                  fontSize: xxLargeFont,
                ),
              ),
              EditButton(
                onPressed: () async {
                  setState(() {
                    isEditing = false;
                  });
                  await Provider.of<AppState>(context, listen: false)
                      .editTitle(item, titleNameController);
                },
                size: 20,
                icon: Icons.check,
              ),
              EditButton(
                onPressed: () {
                  setState(() {
                    isEditing = false;
                  });
                },
                size: 20,
                icon: Icons.close,
              ),
            ],
          ),
        Text(
          "Created: ${getFormatedDate(item.createdDate)}",
          style: const TextStyle(
            color: disabledGray,
            fontSize: smallFont,
          ),
        ),
        Text(
          "Last Update: ${getFormatedDate(item.lastUpdated)}",
          style: const TextStyle(
            color: disabledGray,
            fontSize: smallFont,
          ),
        ),
      ],
    );
  }
}
