import 'package:isar/isar.dart';

part 'content.g.dart';

@embedded
class Content {
  String? text;
  DateTime? dueDate;
  double priority = 2.5;
}
