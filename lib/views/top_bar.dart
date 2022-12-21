import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/models/isar_models/item.dart';
import 'package:taskboard/state/app_state.dart';

class BoardTopBar extends StatelessWidget with PreferredSizeWidget {
  const BoardTopBar({Key? key, required this.item, required this.path})
      : super(key: key);

  final Item? item;
  final String path;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Text(
        path,
        style: const TextStyle(color: Colors.black),
      ),
      leading: GestureDetector(
        onTap: () async {
          if (item != null) {
            var navigator = Navigator.of(context);
            var initilized = await Provider.of<AppState>(context, listen: false)
                .setInitialItem(item!.parentItem.value);
            if (initilized) navigator.pop();
          }
        },
        child: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
    );
  }
}
