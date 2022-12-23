import 'package:flutter/material.dart';
import 'package:taskboard/views/board/columns.dart';

class TaskboardBoard extends StatefulWidget {
  const TaskboardBoard({super.key});

  @override
  State<TaskboardBoard> createState() => _TaskboardBoardState();
}

class _TaskboardBoardState extends State<TaskboardBoard> {
  @override
  Widget build(BuildContext context) {
    return const TaskboardColumns();
  }
}
