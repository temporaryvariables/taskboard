import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/features/main/app_bar_icon_button.dart';
import 'package:taskboard/routes.dart';
import 'package:taskboard/app_state.dart';

class TaskboardTopBar extends StatelessWidget with PreferredSizeWidget {
  const TaskboardTopBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leadingWidth: 0,
      title: Consumer<AppState>(
        builder: (_, appState, __) {
          var currentItem = appState.currentItem;
          return Row(
            children: [
              AppBarIconButton(
                isDisabled: currentItem.parentItem.value == null,
                onPressed: () async {
                  await appState.setBoard(currentItem.parentItem.value!);
                },
                icon: Icons.arrow_back,
                size: null,
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
                  AppBarIconButton(
                    onPressed: () async {
                      var nav = Navigator.of(context);
                      var itemId = await appState.addItemWithText("New Item");
                      var item = await appState.getItemFromId(itemId);
                      nav.push(viewItem(item!));
                    },
                    icon: Icons.add,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  AppBarIconButton(
                    isDisabled: currentItem.viewType == "Board",
                    onPressed: () async {
                      if (currentItem.viewType == "Board") {
                        appState.toggleViewType(true);
                      } else {
                        appState.toggleViewType(false);
                      }
                    },
                    icon: Icons.list_alt,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  AppBarIconButton(
                    onPressed: () async {
                      Navigator.push(context, openSettingsDialogbox());
                    },
                    icon: Icons.settings,
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
