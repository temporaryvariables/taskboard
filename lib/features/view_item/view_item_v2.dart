import 'package:flutter/material.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/features/view_item/attribute_handlers/date_handler.dart';
import 'package:taskboard/features/view_item/attribute_handlers/label_handler.dart';
import 'package:taskboard/features/view_item/attribute_handlers/parent_handler.dart';
import 'package:taskboard/features/view_item/attribute_handlers/priority_handler.dart';
import 'package:taskboard/features/view_item/attribute_handlers/status_handler.dart';
import 'package:taskboard/features/view_item/attribute_handlers/title_handler.dart';
import 'package:taskboard/features/view_item/view_item_top_bar.dart';
import 'package:taskboard/models/isar_models/tb_item.dart';

class ViewItemV2 extends StatefulWidget {
  const ViewItemV2({super.key, required this.item});

  final TBItem item;

  @override
  State<ViewItemV2> createState() => _ViewItemV2State();
}

class _ViewItemV2State extends State<ViewItemV2> {
  TBItem get item => widget.item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ViewItemTopBar(),
      body: SizedBox(
        width: 1200,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: _itemAttributes,
                itemCount: 6,
                padding: const EdgeInsets.all(
                  16.0,
                ),
              ),
            ),
            if (_getScreenWidth(context) > 1000)
              SizedBox(
                width: 400,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: _otherItems,
                  itemCount: 5,
                ),
              ),
          ],
        ),
      ),
    );
  }

  double _getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  Widget _itemAttributes(context, index) {
    switch (index) {
      case 0:
        return TitleHandler(item: item);
      case 1:
        return StatusHandler(item: item);
      case 2:
        return PriorityHandler(item: item);
      case 3:
        return DateHandler(item: item);
      case 4:
        return LabelHandler(item: item);
      case 5:
        return ParentHandler(item: item);
      default:
        return Container(
          color: accent,
          width: 200,
          height: 200,
        );
    }
  }

  Widget _otherItems(context, index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: accent2,
        width: 200,
        height: 200,
      ),
    );
  }
}
