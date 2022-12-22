import 'package:flutter/material.dart';
import 'package:taskboard/views/board/columns.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({super.key});

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  @override
  Widget build(BuildContext context) {
    return const BoardColumns();
  }
}
