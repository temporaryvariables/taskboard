import 'package:flutter/material.dart';
import 'package:taskboard/views/board/columns.dart';
import 'package:taskboard/views/bottom_bar.dart';
import 'package:taskboard/views/top_bar.dart';

class Taskboard extends StatefulWidget {
  const Taskboard({super.key});

  @override
  State<Taskboard> createState() => _TaskboardState();
}

class _TaskboardState extends State<Taskboard> {
  final FocusNode _contextFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const TaskboardTopBar(),
      body: Column(
        children: [
          const TaskboardColumns(),
          TaskboardBottomBar(
            contextFocus: _contextFocus,
          ),
        ],
      ),
    );
  }
}
