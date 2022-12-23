import 'package:flutter/material.dart';
import 'package:taskboard/views/board/board.dart';
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
      backgroundColor: const Color.fromARGB(254, 249, 247, 247),
      appBar: const TaskboardTopBar(),
      body: Column(
        children: [
          const TaskboardBoard(),
          TaskboardBottomBar(
            contextFocus: _contextFocus,
          ),
        ],
      ),
    );
  }
}
