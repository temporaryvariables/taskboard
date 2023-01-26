import 'dart:io';

import 'package:flex_color_scheme/flex_color_scheme.dart';
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
      theme: FlexThemeData.light(
        colors: const FlexSchemeColor(
          primary: Color(0xff004881),
          primaryContainer: Color(0xffd0e4ff),
          secondary: Color(0xffac3306),
          secondaryContainer: Color(0xffffdbcf),
          tertiary: Color(0xff006875),
          tertiaryContainer: Color(0xff95f0ff),
          appBarColor: Color(0xffffdbcf),
          error: Color(0xffb00020),
        ),
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 9,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 10,
          blendOnColors: false,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        // To use the playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      darkTheme: FlexThemeData.dark(
        colors: const FlexSchemeColor(
          primary: Color(0xff9fc9ff),
          primaryContainer: Color(0xff00325b),
          secondary: Color(0xffffb59d),
          secondaryContainer: Color(0xff872100),
          tertiary: Color(0xff86d2e1),
          tertiaryContainer: Color(0xff004e59),
          appBarColor: Color(0xff872100),
          error: Color(0xffcf6679),
        ),
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 15,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        // To use the Playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      home: const TBPage(),
    );
  }
}
