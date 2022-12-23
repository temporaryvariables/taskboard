import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/models/isar_models/tb_item.dart';
import 'package:taskboard/state/app_state.dart';
import 'package:taskboard/views/board/board.dart';

Future<void> main() async {
  Isar isarInstance = await Isar.open([TBItemSchema]);
  var count = await isarInstance.getSize();

  // if "main" board doesnt exist, create it
  if (count == 0) {
    // -1 order signifies main item
    var i = TBItem("Main", "", -1);
    i.boardName = "Main";
    await isarInstance.writeTxn(() async {
      await isarInstance.tBItems.put(i);
    });
  }

  var mainItem =
      await isarInstance.tBItems.filter().orderEqualTo(-1).findFirst();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => AppState(isarInstance, mainItem))
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Inco"),
      home: const Taskboard(),
    );
  }
}
