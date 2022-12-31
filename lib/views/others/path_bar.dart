import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/state/app_state.dart';

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
          color: const Color.fromARGB(255, 173, 216, 230).withOpacity(0.4),
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              );
            },
            scrollDirection: Axis.horizontal,
            itemCount: fullPath.length,
            itemBuilder: (context, index) {
              if (fullPath[index].parentItem.value == null) {
                return GestureDetector(
                  onTap: () async {
                    if (fullPath[index] != value.currentItem) {
                      await value.setBoard(fullPath[index]);
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(6, 5, 6, 5),
                    child: Icon(
                      Icons.home_filled,
                      size: 20,
                    ),
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.fromLTRB(6, 5, 6, 5),
                child: GestureDetector(
                  onTap: () async {
                    if (fullPath[index] != value.currentItem) {
                      await value.setBoard(fullPath[index]);
                    }
                  },
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 120),
                    child: Text(
                      fullPath[index].boardName.toUpperCase(),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16),
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
