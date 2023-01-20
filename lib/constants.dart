import 'package:flutter/material.dart';
import 'package:taskboard/models/isar_models/tb_item.dart';

// Other Constants
const List<String> defaultColumns = ["Backlog", "In Progress", "Done"];
TBItem defaultItem = TBItem("404: Item not found", "default", -1);

enum Menu { addLeft, addRight, remove, edit }

const double cardWidth = 250;
const double minScreen = 450;

// Color Constants
const Color black = Colors.black;
const Color primary = Colors.white;
const Color secondary = Colors.black;
const Color accent = Color.fromARGB(160, 236, 114, 87);
const Color accent2 = Color.fromARGB(140, 44, 102, 110);
const Color lightGray = Colors.black12;
const Color disabledGray = Colors.grey;
const Color enabledBlack = Colors.black;
const Color transparent = Colors.transparent;

const List<Color> columnColors = [
  Color(0xFF9E9E9E), // grey
  Color(0xFF2196F3), // blue
  Color(0xFF4CAF50), // green
  Color(0xFFF44336), // red
  Color(0xFFE91E63), // pink
  Color(0xFF9C27B0), // purple
  Color(0xFF673AB7), // deep purple
  Color(0xFF3F51B5), // indigo
  Color(0xFF03A9F4), // light blue
  Color(0xFF00BCD4), // cyan
  Color(0xFF009688), // teal
  Color(0xFF8BC34A), // light green
  Color(0xFFCDDC39), // lime
  Color(0xFFFFEB3B), // yellow
  Color(0xFFFFC107), // amber
  Color(0xFFFF9800), // orange
  Color(0xFFFF5722), // deep orange
  Color(0xFF795548), // brown
  Color(0xFF607D8B), // blue grey
  Color(0xFF000000), // black
  Color(0xFFFFFFFF) // white
];

// Calendar Constants
List<String> months = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
];

List<String> days = [
  "Sun",
  "Mon",
  "Tue",
  "Wed",
  "Thu",
  "Fri",
  "Sat",
];
