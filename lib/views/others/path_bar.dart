import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/constants.dart';
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
          color: accent2,
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
                      fullPath[index].safeText.toUpperCase(),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
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
