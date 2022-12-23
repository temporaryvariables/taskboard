import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/state/app_state.dart';

class TaskboardTopBar extends StatelessWidget with PreferredSizeWidget {
  const TaskboardTopBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            appState.getFullPath(),
            style: const TextStyle(color: Colors.black),
          ),
          leading: GestureDetector(
            onTap: () async {
              Navigator.pop(context);
              await appState.setBoard(appState.parentItem.parentItem.value!);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        );
      },
    );
  }
}
