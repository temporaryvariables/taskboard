import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:taskboard/models/isar_models/tb_column.dart';

part 'tb_item.g.dart';

const List<TBColumn> defaultColumns = [];

@collection
class TBItem {
  Id id = Isar.autoIncrement;
  late DateTime createdDate;
  late DateTime lastUpdated;
  String text;
  DateTime? dueDate;
  double? priority;
  String column;
  int order;
  String? boardName;
  late List<TBColumn> boardColumns;
  IsarLink<TBItem> parentItem = IsarLink<TBItem>();
  IsarLinks<TBItem> boardItems = IsarLinks<TBItem>();

  TBItem(this.text, this.column, this.order) {
    var now = DateTime.now();
    createdDate = now;
    lastUpdated = now;
    boardName = text;

    var backlog = TBColumn();
    backlog.name = "Backlog";
    backlog.color = Colors.grey.value.toString();

    var inProgress = TBColumn();
    inProgress.name = "In Progress";
    inProgress.color = Colors.blue.value.toString();

    var done = TBColumn();
    done.name = "Done";
    done.color = Colors.green.value.toString();

    boardColumns = [backlog, inProgress, done];
  }

  List<String> get boardColumnsAsStrings {
    return boardColumns.map((e) => e.name).toList();
  }

  @override
  bool operator ==(dynamic other) => other != null && other.id == id;

  @override
  int get hashCode => super.hashCode;
}
