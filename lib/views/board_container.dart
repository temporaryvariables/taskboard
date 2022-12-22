import 'package:flutter/material.dart';
import 'package:taskboard/views/board/board.dart';
import 'package:taskboard/views/bottom_bar.dart';
import 'package:taskboard/views/top_bar.dart';

class BoardContainer extends StatefulWidget {
  const BoardContainer({super.key});

  @override
  State<BoardContainer> createState() => _BoardContainerState();
}

class _BoardContainerState extends State<BoardContainer> {
  final FocusNode _contextFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(254, 249, 247, 247),
      appBar: const BoardTopBar(),
      body: Column(
        children: [
          const BoardPage(),
          BoardBottomBar(
            contextFocus: _contextFocus,
          ),
        ],
      ),
    );
  }
}
