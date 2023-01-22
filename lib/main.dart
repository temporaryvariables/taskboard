import 'dart:io';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskboard/models/isar_models/tb_item.dart';
import 'package:taskboard/app_state.dart';
import 'package:taskboard/features/main/board_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.remove("defaultInstance");
  sharedPreferences.remove("isarInstances");
  Isar isarInstance = await init(sharedPreferences);

  validateMainBoard(isarInstance);

  var mainItem =
      await isarInstance.tBItems.filter().orderEqualTo(-1).findFirst();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
              AppState(sharedPreferences, isarInstance, mainItem),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

Future<Isar> init(SharedPreferences prefs) async {
  var defaultInstance = prefs.getString("defaultInstance");
  if (defaultInstance != null) {
    return await isarInstanceByPath(defaultInstance);
  } else {
    Isar isarInstance = await Isar.open([TBItemSchema]);
    prefs.setString("defaultInstance", isarInstance.path!);
    addNewInstanceToSettings(prefs, isarInstance);
    return isarInstance;
  }
}

Future<Isar> isarInstanceByPath(String path) async {
  File file = File(path);
  return await Isar.open([TBItemSchema],
      directory: file.parent.path,
      name: file.path.split('/').last.split('.').first);
}

void addNewInstanceToSettings(SharedPreferences prefs, Isar inst) async {
  var instances = prefs.getStringList("isarInstances") ?? [];
  if (!instances.contains(inst.path!)) {
    instances.add(inst.path!);
    await prefs.setStringList("isarInstances", instances);
  }
}

void validateMainBoard(Isar inst) async {
  var count = await inst.getSize();

  // if "main" board doesnt exist, create it
  if (count == 0) {
    // -1 order signifies main item
    var i = TBItem("Main", "", -1);
    await inst.writeTxn(() async {
      await inst.tBItems.put(i);
    });
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Lato"),
      home: const TBPage(),
    );
  }
}
