import 'package:isar/isar.dart';

part 'item.g.dart';

const List<String> defaultColumns = ["Backlog", "In Progress", "Done"];

@collection
class Item {
  Id id = Isar.autoIncrement;
  late DateTime createdDate;
  late DateTime lastUpdated;
  String? content;
  String column;
  int order;
  String? boardName;
  List<String> boardColumns = defaultColumns;
  IsarLink<Item> parentItem = IsarLink<Item>();
  IsarLinks<Item> boardItems = IsarLinks<Item>();

  Item(this.content, this.column, this.order) {
    var now = DateTime.now();
    createdDate = now;
    lastUpdated = now;
  }
}
