import 'package:flutter/material.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/features/main/board/columns.dart';
import 'package:taskboard/features/main/bottom_bar.dart';
import 'package:taskboard/features/main/path_bar.dart';
import 'package:taskboard/features/main/top_bar.dart';

class TaskboardPage extends StatefulWidget {
  const TaskboardPage({super.key});

  @override
  State<TaskboardPage> createState() => _TaskboardPageState();
}

class _TaskboardPageState extends State<TaskboardPage> {
  final FocusNode _contextFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: MediaQuery.of(context).size.width > minScreen
          ? const TaskboardTopBar()
          : null,
      body: Column(
        children: [
          const PathBar(),
          const TaskboardColumns(),
          if (MediaQuery.of(context).size.width > minScreen)
            TaskboardBottomBar(
              contextFocus: _contextFocus,
            ),
        ],
      ),
    );
  }
}
