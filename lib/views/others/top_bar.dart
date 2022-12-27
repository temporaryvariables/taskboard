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
        var parentItem = appState.currentItem.parentItem.value;
        return AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    appState.getFullPath(),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Switch(
                activeColor: Colors.black,
                value: appState.currentItem.viewType != "Board",
                onChanged: (value) {
                  appState.toggleViewType(value);
                },
              ),
            ],
          ),
          leadingWidth: 28,
          leading: GestureDetector(
            onTap: () async {
              if (parentItem != null) {
                await appState.setBoard(parentItem);
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Icon(
                parentItem != null ? Icons.arrow_back_ios : Icons.home,
                color: Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }
}
