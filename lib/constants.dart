import 'package:flutter/material.dart';
import 'package:taskboard/models/isar_models/tb_item.dart';

const List<String> defaultColumns = ["Backlog", "In Progress", "Done"];
TBItem defaultItem = TBItem("404: Item not found", "default", -1);

const double cardWidth = 250;

enum Menu { addLeft, addRight, remove, edit }

const double minScreen = 450;

const IconData listIcon = Icons.list_alt;
const IconData leftArrowIcon = Icons.arrow_back;

const Color iconDisabled = Colors.black26;
const Color iconEnabled = Colors.black;

const Color textBlack = Colors.black;
const Color textLightBlack = Colors.black26;
const Color backgroundWhite = Colors.white;
const Color backgroundLightWhite = Color.fromARGB(179, 222, 220, 220);
const Color backgroundTodayWhite = Color.fromARGB(179, 241, 226, 226);

const List<Color> colors = [
  Color(0xFFF44336), // red
  Color(0xFFE91E63), // pink
  Color(0xFF9C27B0), // purple
  Color(0xFF673AB7), // deep purple
  Color(0xFF3F51B5), // indigo
  Color(0xFF2196F3), // blue
  Color(0xFF03A9F4), // light blue
  Color(0xFF00BCD4), // cyan
  Color(0xFF009688), // teal
  Color(0xFF4CAF50), // green
  Color(0xFF8BC34A), // light green
  Color(0xFFCDDC39), // lime
  Color(0xFFFFEB3B), // yellow
  Color(0xFFFFC107), // amber
  Color(0xFFFF9800), // orange
  Color(0xFFFF5722), // deep orange
  Color(0xFF795548), // brown
  Color(0xFF9E9E9E), // grey
  Color(0xFF607D8B), // blue grey
  Color(0xFF000000), // black
  Color(0xFFFFFFFF) // white
];
