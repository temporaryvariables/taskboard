import 'package:flutter/material.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/features/main/columns.dart';
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
      backgroundColor: const Color.fromARGB(255, 241, 238, 238),
      appBar: MediaQuery.of(context).size.width > minScreen
          ? const TaskboardTopBar()
          : null,
      body: Column(
        children: [
          const PathBar(),
          const TBColumns(),
          if (MediaQuery.of(context).size.width > minScreen)
            TaskboardBottomBar(
              contextFocus: _contextFocus,
            ),
        ],
      ),
    );
  }
}
