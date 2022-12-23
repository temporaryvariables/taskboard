import 'package:flutter/material.dart';
import 'package:taskboard/models/isar_models/item.dart';
import 'package:taskboard/views/board/edit_card.dart';
import 'package:taskboard/views/board/edit_column.dart';
import 'package:taskboard/views/board_container.dart';

Route<Widget> openNewBoard(Item i) {
  return PageRouteBuilder<Widget>(
    opaque: false,
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) =>
        const BoardContainer(),
    transitionsBuilder: (BuildContext context, Animation<double> animation,
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
    },
  );
}

Route<Widget> openEditCard(Item item) {
  return PageRouteBuilder<Widget>(
    opaque: false,
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) =>
        EditCard(
      item: item
    ),
    transitionsBuilder: (BuildContext context, Animation<double> animation,
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
    },
  );
}

Route<Widget> openEditColumn(int index, Item item) {
  return PageRouteBuilder<Widget>(
    opaque: false,
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) =>
        EditColumn(
      item: item,
      index: index,
    ),
    transitionsBuilder: (BuildContext context, Animation<double> animation,
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
    },
  );
}
