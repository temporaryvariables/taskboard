import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:taskboard/models/isar_models/isar_column.dart';
import 'package:taskboard/models/isar_models/content.dart';

part 'item.g.dart';

const List<IsarColumn> defaultColumns = [];

@collection
class Item {
  Id id = Isar.autoIncrement;
  late DateTime createdDate;
  late DateTime lastUpdated;
  Content content;
  String column;
  int order;
  String? boardName;
  late List<IsarColumn> boardColumns;
  IsarLink<Item> parentItem = IsarLink<Item>();
  IsarLinks<Item> boardItems = IsarLinks<Item>();

  Item(this.content, this.column, this.order) {
    var now = DateTime.now();
    createdDate = now;
    lastUpdated = now;

    var backlog = IsarColumn();
    backlog.name = "Backlog";
    backlog.color = Colors.grey.value.toString();

    var inProgress = IsarColumn();
    inProgress.name = "In Progress";
    inProgress.color = Colors.blue.value.toString();

    var done = IsarColumn();
    done.name = "Done";
    done.color = Colors.green.value.toString();

    boardColumns = [backlog, inProgress, done];
  }

  List<String> get boardColumnsAsStrings {
    return boardColumns.map((e) => e.name).toList();
  }
}
