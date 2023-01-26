import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/routes.dart';
import 'package:taskboard/app_state.dart';

class EditColumnTopBar extends StatelessWidget with PreferredSizeWidget {
  const EditColumnTopBar({Key? key}) : super(key: key);

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
          backgroundColor: primary,
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
                        Icons.arrow_back,
                        color: black,
                      )
                    : const Icon(
                        Icons.arrow_back,
                        color: disabledGray,
                      ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (currentItem.parentItem.value != null) {
                      Navigator.push(context, viewItem(currentItem));
                    }
                  },
                  child: Text(
                    currentItem.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      color: black,
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
                        style: TextStyle(color: black, fontSize: 14),
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
                      nav.push(viewItem(item!));
                    },
                    child: const Icon(
                      Icons.add,
                      color: black,
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
                      Icons.list_alt,
                      color: (appState.currentItem.viewType == "Board")
                          ? lightGray
                          : black,
                      size: 28,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () async {
                      Navigator.push(context, openSettingsDialogbox());
                    },
                    child: const Icon(
                      Icons.settings,
                      color: black,
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
