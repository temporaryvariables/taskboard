import 'package:flutter/material.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/features/view_item/edit_item/edit_date.dart';
import 'package:taskboard/features/view_item/edit_item/edit_parent.dart';
import 'package:taskboard/features/view_item/view_item_v2.dart';
import 'package:taskboard/models/isar_models/tb_item.dart';
import 'package:taskboard/features/edit_column/edit_column_page.dart';
import 'package:taskboard/features/settings/settings_page.dart';

Route<Widget> openEditItemDialogbox(TBItem item) {
  return PageRouteBuilder<Widget>(
    opaque: false,
    barrierColor: lightGray,
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) =>
        ViewItemV2(item: item),
    transitionsBuilder: _transactionBuilder,
  );
}

Route<Widget> openEditColumnDialogbox(int index, TBItem item) {
  return PageRouteBuilder<Widget>(
    opaque: false,
    barrierColor: lightGray,
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) =>
        EditColumnPage(
      item: item,
      index: index,
    ),
    transitionsBuilder: _transactionBuilder,
  );
}

Route<Widget> openSettingsDialogbox() {
  return PageRouteBuilder<Widget>(
    opaque: false,
    barrierColor: lightGray,
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) =>
        const SettingsPage(),
    transitionsBuilder: _transactionBuilder,
  );
}

Route<Widget> editDueDate(TBItem item) {
  return PageRouteBuilder<Widget>(
    opaque: false,
    barrierColor: lightGray,
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) =>
        DateSelector(
      item: item,
    ),
    transitionsBuilder: _transactionBuilder,
  );
}

Route<Widget> editParentItem(TBItem item) {
  return PageRouteBuilder<Widget>(
    opaque: false,
    barrierColor: lightGray,
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) =>
        ParentSelector(
      item: item,
    ),
    transitionsBuilder: _transactionBuilder,
  );
}

Widget _transactionBuilder(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  const Offset begin = Offset(0.0, 1.0);
  const Offset end = Offset.zero;
  const Cubic curve = Curves.ease;

  final Animatable<Offset> tween =
      Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

  return SlideTransition(
    position: animation.drive(tween),
    child: child,
  );
}
