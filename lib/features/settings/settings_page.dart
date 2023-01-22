import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/models/isar_models/tb_item.dart';
import 'package:taskboard/app_state.dart';
import 'package:taskboard/features/settings/database_card.dart';
import 'package:taskboard/features/shared/dialog_box.dart';
import 'package:taskboard/features/shared/textfield.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late AppState currentState;
  TextEditingController dbNameController = TextEditingController();
  TextEditingController dbDirectoryController = TextEditingController();
  bool isCreatingNewDbValid = false;

  @override
  void initState() {
    super.initState();
    currentState = Provider.of<AppState>(context, listen: false);
    currentState.cleanupTrackedDbs();

    dbNameController.addListener(() {
      if (dbNameController.text.isNotEmpty) {
        setState(() {
          isCreatingNewDbValid = true;
        });
      } else {
        setState(() {
          isCreatingNewDbValid = false;
        });
      }
    });

    dbDirectoryController.addListener(() {
      if (dbDirectoryController.text.isNotEmpty) {
        setState(() {
          isCreatingNewDbValid = true;
        });
      } else {
        setState(() {
          isCreatingNewDbValid = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DialogBox(
      title: "Settings",
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Current database",
              style: TextStyle(fontSize: 14),
            ),
            Consumer<AppState>(
              builder: (context, value, child) {
                return DatabaseCard(path: value.isarInstance.path!);
              },
            ),
            const Divider(),
            const Text(
              "Create a new database",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Database name",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(
              height: 2,
            ),
            TBTextfield(
              textController: dbNameController,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Database directory",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(
              height: 2,
            ),
            Row(
              children: [
                Expanded(
                  child: TBTextfield(
                    textController: dbDirectoryController,
                    readOnly: true,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    FilePicker.platform
                        .getDirectoryPath()
                        .then((value) => dbDirectoryController.text = value!);
                  },
                  child: const Icon(Icons.file_copy_outlined),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: MaterialButton(
                onPressed: (dbDirectoryController.text.isNotEmpty &&
                        dbNameController.text.isNotEmpty)
                    ? () async {
                        await currentState.isarInstance.close();
                        Isar isarInstance = await Isar.open(
                          [TBItemSchema],
                          directory: dbDirectoryController.text,
                          name: dbNameController.text,
                        );
                        await currentState.addNewDbsToSettings(isarInstance);
                        await currentState.openIsarInstance(isarInstance);
                        dbNameController.clear();
                        dbDirectoryController.clear();
                      }
                    : null,
                child: const Text(
                  "Create Database",
                  style: TextStyle(
                    color: black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Divider(),
            const Text(
              "Import a database",
              style: TextStyle(fontSize: 14),
            ),
            MaterialButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['isar'],
                );

                if (result != null) {
                  await currentState.isarInstance.close();
                  final File file = File(result.files.single.path!);
                  Isar isarInstance = await Isar.open(
                    [TBItemSchema],
                    directory: file.parent.path,
                    name: file.path.split('\\').last.split('.').first,
                  );
                  await currentState.openIsarInstance(isarInstance);
                  await currentState.addNewDbsToSettings(isarInstance);
                }
              },
              child: const Text(
                "Import Database",
                style: TextStyle(
                  color: black,
                ),
              ),
            ),
            const Divider(),
            const Text(
              "All databases",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(
              height: 2,
            ),
            Container(
              constraints: const BoxConstraints(maxHeight: 200),
              child: Consumer<AppState>(
                builder: (context, value, child) {
                  var defaultDb = value.getDefaultDb();
                  return FutureBuilder(
                    future: value.getDbsFromSettings(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.data != null &&
                          snapshot.data!.isNotEmpty) {
                        List<String> paths = snapshot.data!;
                        paths = paths
                            .where((element) =>
                                element != currentState.isarInstance.path)
                            .toList();
                        return ListView.builder(
                          itemCount: paths.length,
                          itemBuilder: (context, index) {
                            return DatabaseCard(
                              isDefault: paths[index] == defaultDb,
                              path: paths[index],
                              onOpen: () async {
                                await value.isarInstance.close();
                                var result = paths[index];
                                final File file = File(result);
                                Isar isarInstance = await Isar.open(
                                  [TBItemSchema],
                                  directory: file.parent.path,
                                  name: file.path
                                      .split('/')
                                      .last
                                      .split('.')
                                      .first,
                                );
                                value.openIsarInstance(isarInstance);
                              },
                              onDelete: () {
                                value.removeDbFromSettings(paths[index]);
                              },
                              onDefault: () {
                                value.setDefaultDbs(paths[index]);
                              },
                            );
                          },
                        );
                      } else {
                        return const Card(
                          elevation: 0,
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("No previous databases"),
                            ),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
