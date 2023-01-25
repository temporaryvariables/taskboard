import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/app_state.dart';

class ViewItemTopBar extends StatelessWidget with PreferredSizeWidget {
  const ViewItemTopBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (_, appState, __) {
        return AppBar(
          elevation: 0,
          leadingWidth: 0,
          backgroundColor: primary,
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: black,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
