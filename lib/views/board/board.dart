import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/models/isar_models/item.dart';
import 'package:taskboard/state/app_state.dart';
import 'package:taskboard/views/board/columns.dart';
import 'package:taskboard/views/bottom_bar.dart';
import 'package:taskboard/views/top_bar.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({super.key, this.item});

  final Item? item;

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  final FocusNode _contextFocus = FocusNode();
  Future<void>? initilized;

  @override
  void initState() {
    super.initState();
    AppState currentState = Provider.of<AppState>(context, listen: false);
    initilized = currentState.setInitialItem(widget.item);
  }

  // TODO: still not working properly, not sure why
  String getFullPath() {
    var pointer = widget.item;
    String path = "";
    while (pointer != null) {
      path = "${pointer.boardName!}\\$path";
      pointer = pointer.parentItem.value;
    }
    return path;
  }

  @override
  void dispose() {
    super.dispose();
    _contextFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(254, 249, 247, 247),
      appBar: BoardTopBar(
        item: widget.item,
        path: getFullPath(),
      ),
      body: FutureBuilder(
        future: initilized,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              color: Colors.blue.shade100,
            );
          }
          return Column(
            children: [
              const BoardColumns(),
              BoardBottomBar(
                contextFocus: _contextFocus,
              ),
            ],
          );
        },
      ),
    );
  }
}
