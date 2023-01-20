import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:taskboard/constants.dart';
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
  String viewType = "Board";
  late List<TBColumn> boardColumns;
  IsarLink<TBItem> parentItem = IsarLink<TBItem>();
  IsarLinks<TBItem> boardItems = IsarLinks<TBItem>();

  TBItem(this.text, this.column, this.order) {
    var now = DateTime.now();
    createdDate = now;
    lastUpdated = now;

    var backlog = TBColumn();
    backlog.name = "Backlog";
    backlog.color = columnColors[0];

    var inProgress = TBColumn();
    inProgress.name = "In Progress";
    inProgress.color = columnColors[1];

    var done = TBColumn();
    done.name = "Done";
    done.color = columnColors[2];

    boardColumns = [backlog, inProgress, done];
  }

  @ignore
  get safeText {
    if (text.length < 16) {
      return text.trim();
    } else {
      return "${text.trim().substring(0, 16)}...";
    }
  }

  @ignore
  String get itemDisplayString => "[$id] $text";

  List<String> get boardColumnsAsStrings {
    return boardColumns.map((e) => e.name).toList();
  }

  @override
  bool operator ==(dynamic other) => other != null && other.id == id;

  @override
  int get hashCode => super.hashCode;
}
