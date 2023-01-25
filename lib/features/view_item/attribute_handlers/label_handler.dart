import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/app_state.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/features/view_item/attribute_handlers/attribute_basic.dart';
import 'package:taskboard/features/view_item/attribute_handlers/edit_button.dart';
import 'package:taskboard/models/isar_models/tb_item.dart';

class LabelHandler extends StatefulWidget {
  const LabelHandler({super.key, required this.item});

  final TBItem item;

  @override
  State<LabelHandler> createState() => _LabelHandlerState();
}

class _LabelHandlerState extends State<LabelHandler> {
  TextEditingController labelController = TextEditingController();
  TBItem get item => widget.item;
  bool isAddingLabel = false;

  String _formatLabel(String label) {
    label = label.replaceAll(RegExp(r"[^a-zA-Z0-9]"), "");
    if (label[0] != "#") {
      label = "#$label";
    }
    return label.toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return AttributeBasic(
      name: "Label",
      child: Consumer<AppState>(
        builder: (context, appState, child) {
          return Column(
            children: [
              Row(
                children: [
                  if (isAddingLabel == true)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: CupertinoTextField(
                            controller: labelController,
                            padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                          ),
                        ),
                        EditButton(
                          onPressed: () {
                            if (labelController.text.isNotEmpty &&
                                item.labels.contains(
                                        _formatLabel(labelController.text)) ==
                                    false) {
                              var label = _formatLabel(labelController.text);
                              item.labels = [label, ...item.labels];
                              appState.addItem(item);
                            }
                            labelController.clear();
                          },
                          icon: Icons.check,
                        ),
                        EditButton(
                          onPressed: () {
                            setState(() {
                              isAddingLabel = false;
                            });
                          },
                          icon: Icons.close,
                        ),
                      ],
                    )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: [
                        for (int i = 0; i < item.labels.length; i++)
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Container(
                              height: 22,
                              decoration: BoxDecoration(
                                color: accent,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                  horizontal: 4,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      item.labels[i],
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: black,
                                        fontSize: mediumFont,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        item.labels = [
                                          ...item.labels.sublist(0, i),
                                          ...item.labels.sublist(i + 1)
                                        ];
                                        appState.addItem(item);
                                      },
                                      child: const Icon(
                                        Icons.close,
                                        size: 12,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        if (!isAddingLabel)
                          EditButton(onPressed: () {
                            setState(() {
                              isAddingLabel = true;
                            });
                          }),
                      ],
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
