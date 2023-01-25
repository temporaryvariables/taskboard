import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/app_state.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/models/isar_models/tb_item.dart';

class ParentSelector extends StatefulWidget {
  const ParentSelector({super.key, required this.item});

  final TBItem item;

  @override
  State<ParentSelector> createState() => _ParentSelectorState();
}

class _ParentSelectorState extends State<ParentSelector> {
  TextEditingController searchController = TextEditingController();
  late TBItem currentParent;
  late Future<List<TBItem>> possibleParents;
  TBItem get item => widget.item;

  @override
  void initState() {
    super.initState();
    possibleParents = Provider.of<AppState>(context, listen: false)
        .getPossibleParentItems2(item);
    currentParent = item.parentItem.value!;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 550,
        width: 400,
        child: Card(
          elevation: 1,
          borderOnForeground: true,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 25, 20, 25),
            child: Column(
              children: [
                Consumer<AppState>(
                  builder: (context, value, child) {
                    return Row(
                      children: [
                        Text(
                          "Parent Item: ${item.parentItem.value?.itemIdentifier ?? "None"}",
                          style: const TextStyle(fontSize: normalFont),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                CupertinoTextField(
                  prefix: const Padding(
                    padding: EdgeInsets.only(left: 6),
                    child: Icon(
                      Icons.search,
                      color: black,
                      size: 20,
                    ),
                  ),
                  placeholder: "Search",
                  controller: searchController,
                  padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                ),
                const SizedBox(
                  height: 16,
                ),
                Consumer<AppState>(
                  builder: (context, value, child) {
                    return Expanded(
                      child: FutureBuilder(
                        future: possibleParents,
                        builder: (context, snapshot) {
                          if (snapshot.data == null || snapshot.data!.isEmpty) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 6),
                              child: Text("Loading..."),
                            );
                          }
                          var allPossibleItems = snapshot.data ?? [];
                          return ListView.separated(
                            itemCount: allPossibleItems.length,
                            separatorBuilder: (context, index) {
                              return const Divider(
                                height: 1,
                                thickness: 1,
                              );
                            },
                            itemBuilder: (context, index) {
                              var possibleItem = allPossibleItems[index];
                              return ListTile(
                                title: Text(possibleItem.itemIdentifier),
                                visualDensity: VisualDensity.compact,
                                enabled: item.parentItem.value != possibleItem,
                                onTap: () async {
                                  await value.moveItem(possibleItem, item);
                                },
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        if (item.parentItem.value != currentParent) {
                          Provider.of<AppState>(context, listen: false)
                              .moveItem(currentParent, item);
                        }
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: black),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Done",
                        style: TextStyle(color: black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
