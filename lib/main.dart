import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/models/isar_models/item.dart';
import 'package:taskboard/state/app_state.dart';
import 'package:taskboard/views/board/board.dart';

Future<void> main() async {
  Isar isarInstance = await Isar.open([ItemSchema]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppState(isarInstance))
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
      home: const BoardPage(),
    );
  }
}
