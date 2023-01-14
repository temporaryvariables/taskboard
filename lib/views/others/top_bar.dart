import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/routes.dart';
import 'package:taskboard/state/app_state.dart';

class TaskboardTopBar extends StatelessWidget with PreferredSizeWidget {
  const TaskboardTopBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (_, appState, __) {
        var currentItem = appState.currentItem;
        return AppBar(
          elevation: 0,
          leadingWidth: 0,
          backgroundColor: backgroundWhite,
          title: Row(
            children: [
              GestureDetector(
                onTap: (currentItem.parentItem.value != null)
                    ? () async {
                        await appState.setBoard(currentItem.parentItem.value!);
                      }
                    : null,
                child: (currentItem.parentItem.value != null)
                    ? const Icon(
                        leftArrowIcon,
                        color: iconEnabled,
                      )
                    : const Icon(
                        leftArrowIcon,
                        color: iconDisabled,
                      ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, openEditCard(currentItem));
                  },
                  child: Text(
                    currentItem.text,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Row(
                children: [
                  if (appState.currentItem.order != -1)
                    GestureDetector(
                      onTap: () async {
                        await appState.setMainBoard();
                      },
                      child: const Text(
                        "Main",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () async {
                      var nav = Navigator.of(context);
                      var itemId = await appState.addItemWithText("New Item");
                      var item = await appState.getItemFromId(itemId);
                      nav.push(openEditCard(item!));
                    },
                    child: const Icon(
                      Icons.add,
                      color: iconEnabled,
                      size: 28,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (appState.currentItem.viewType == "Board") {
                        appState.toggleViewType(true);
                      } else {
                        appState.toggleViewType(false);
                      }
                    },
                    child: Icon(
                      listIcon,
                      color: (appState.currentItem.viewType == "Board")
                          ? iconDisabled
                          : iconEnabled,
                      size: 28,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () async {
                      // TODO: Need to implement
                    },
                    child: const Icon(
                      Icons.settings,
                      color: iconEnabled,
                      size: 28,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
