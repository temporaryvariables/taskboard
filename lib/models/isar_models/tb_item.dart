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

  String title;
  String? description;
  DateTime? dueDate;
  DateTime? endDate;
  double? priority;
  String status;
  List<String> labels = [];

  int order;
  String viewType = "Board";
  List<TBColumn> boardColumns = defaultBoardColumns;
  IsarLink<TBItem> parentItem = IsarLink<TBItem>();
  IsarLinks<TBItem> boardItems = IsarLinks<TBItem>();

  TBItem(this.title, this.status, this.order) {
    var now = DateTime.now();
    createdDate = now;
    lastUpdated = now;
  }

  @ignore
  String get itemIdentifier => "[$id] $title";

  List<String> get boardColumnsAsStrings {
    return boardColumns.map((tbColumns) => tbColumns.name).toList();
  }

  @override
  bool operator ==(dynamic other) => other != null && other.id == id;

  @override
  // ignore: unnecessary_overrides
  int get hashCode => super.hashCode;
}
