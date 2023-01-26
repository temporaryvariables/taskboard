import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/app_state.dart';

class PathBar extends StatelessWidget {
  const PathBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (_, value, __) {
        var fullPath = value.getFullPath();
        return Container(
          height: 30,
          padding: const EdgeInsets.only(left: 14),
          color: Theme.of(context).primaryColor,
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).appBarTheme.backgroundColor,
                size: 14,
              );
            },
            scrollDirection: Axis.horizontal,
            itemCount: fullPath.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: GestureDetector(
                  onTap: () async {
                    if (fullPath[index] != value.currentItem) {
                      await value.setBoard(fullPath[index]);
                    }
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      fullPath[index].title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).appBarTheme.backgroundColor,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
