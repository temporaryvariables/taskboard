import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part "tb_column.g.dart";

@embedded
class TBColumn {
  String name = "default";
  String color = Colors.blue.value.toString();

  @ignore
  Color get colorAsColor => Color(int.parse(color));
}
