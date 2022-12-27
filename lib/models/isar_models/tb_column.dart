import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part "tb_column.g.dart";

@embedded
class TBColumn {
  String name = "default";
  int colorAsInt = Colors.black.value;

  @ignore
  Color get color => Color(colorAsInt);

  set color(Color color) {
    colorAsInt = color.value;
  }
}
