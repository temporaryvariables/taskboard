import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/models/isar_models/tb_column.dart';
import 'package:taskboard/models/isar_models/tb_item.dart';

class AppState with ChangeNotifier {
  late Isar isarInstance;
  TextEditingController cliController = TextEditingController();
  late SharedPreferences sharedPreferences;

  late TBItem currentItem;

  DateTime? _selectedDate;

  set selectedDate(DateTime? date) {
    _selectedDate = date;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

  AppState(SharedPreferences prefs, Isar inst, TBItem? item) {
    sharedPreferences = prefs;
    isarInstance = inst;
    currentItem = item ?? defaultItem;

    cliController.addListener(() {
      if (!cliController.text.startsWith('\\')) {
        notifyListeners();
      }
    });

    reWatch();
  }

  Future<bool> openIsarInstance(Isar inst) async {
    isarInstance = inst;
    var count = await isarInstance.getSize();
    if (count == 0) await _createMainBoard();
    var mainItem =
        await isarInstance.tBItems.filter().orderEqualTo(-1).findFirst();
    currentItem = mainItem ?? defaultItem;
    cliController.addListener(() {
      if (!cliController.text.startsWith('\\')) notifyListeners();
    });
    reWatch();
    notifyListeners();
    return true;
  }

  Future<int> _createMainBoard() async {
    var i = TBItem("Main", "", -1);
    await isarInstance.writeTxn(() async {
      return await isarInstance.tBItems.put(i);
    });
    return -1;
  }

  Future<bool> cleanupTrackedDbs() async {
    var paths = await getDbsFromSettings();
    for (var path in paths) {
      if (!await checkIfFileExists(path)) {
        var instances = sharedPreferences.getStringList("isarInstances") ?? [];
        instances.remove(path);
        sharedPreferences.setStringList("isarInstances", instances);
      }
    }
    return true;
  }

  Future<bool> removeDbFromSettings(String path) async {
    var instances = sharedPreferences.getStringList("isarInstances") ?? [];
    instances.remove(path);
    var isCompleted =
        sharedPreferences.setStringList("isarInstances", instances);
    if (getDefaultDb() == path) {
      sharedPreferences.remove("defaultInstance");
    }
    notifyListeners();
    return isCompleted;
  }

  Future<bool> setDefaultDbs(String path) async {
    var isCompleted =
        await sharedPreferences.setString("defaultInstance", path);
    notifyListeners();
    return isCompleted;
  }

  String? getDefaultDb() {
    return sharedPreferences.getString("defaultInstance");
  }

  Future<bool> checkIfFileExists(String path) async {
    var file = File(path);
    return file.existsSync();
  }

  Future<bool> addNewDbsToSettings(Isar instanceToAdd) async {
    var instances = sharedPreferences.getStringList("isarInstances") ?? [];
    if (!instances.contains(instanceToAdd.path!)) {
      instances.add(instanceToAdd.path!);
      sharedPreferences.setStringList("isarInstances", instances);
    }
    return true;
  }

  Future<List<String>> getDbsFromSettings() async {
    return sharedPreferences.getStringList("isarInstances") ?? [];
  }

  void reWatch() {
    watchParent();
    watchChildren();
  }

  void watchParent() {
    isarInstance.tBItems
        .watchObject(currentItem.id, fireImmediately: true)
        .listen(
      (event) async {
        currentItem = (await isarInstance.tBItems
                .where()
                .filter()
                .idEqualTo(currentItem.id)
                .findFirst()) ??
            defaultItem;
        notifyListeners();
      },
    );
  }

  Future<List<TBItem>> getPossibleParentItems2(TBItem excludeItem) async {
    var mainItem = await getMainBoard();
    return getPossibleParentItems(mainItem!, excludeItem);
  }

  List<TBItem> getPossibleParentItems(TBItem parentItem, TBItem excludeItem) {
    if (excludeItem.id == parentItem.id) return [];
    if (parentItem.boardItems.isEmpty) return [parentItem];
    List<TBItem> items = [];
    for (var item in parentItem.boardItems) {
      items.addAll(getPossibleParentItems(item, excludeItem));
    }
    return [parentItem]..addAll(items);
  }

  void watchChild(int id) {
    isarInstance.tBItems.watchObject(id, fireImmediately: true).listen(
      (event) async {
        currentItem = (await isarInstance.tBItems
                .where()
                .filter()
                .idEqualTo(currentItem.id)
                .findFirst()) ??
            defaultItem;
        notifyListeners();
      },
    );
  }

  void watchChildren() {
    for (var children in currentItem.boardItems) {
      watchChild(children.id);
    }
  }

  Future<void> setMainBoard() async {
    var mainItem =
        await isarInstance.tBItems.filter().orderEqualTo(-1).findFirst();
    if (mainItem != null) {
      await setBoard(mainItem);
    }
  }

  Future<TBItem?> getMainBoard() async {
    return await isarInstance.tBItems.filter().orderEqualTo(-1).findFirst();
  }

  Future<void> setBoard(TBItem item) async {
    if (item.id == currentItem.id) return;

    currentItem = (await isarInstance.tBItems
            .where()
            .filter()
            .idEqualTo(item.id)
            .findFirst()) ??
        defaultItem;

    reWatch();
    notifyListeners();
  }

  List<TBItem> getFullPath() {
    TBItem? pointer = currentItem;
    List<TBItem> boardItems = [];
    while (pointer != null) {
      boardItems.add(pointer);
      pointer = pointer.parentItem.value;
    }
    return boardItems.reversed.toList();
  }

  Future<int> addItemWithText(String text) async {
    var column = currentItem.boardColumns.first.name;
    var order = currentItem.boardItems
        .toList()
        .where((element) => element.column == column)
        .length;
    var i = TBItem(text, column, order);
    i.parentItem.value = currentItem;
    var id = -1;
    await isarInstance.writeTxn(() async {
      id = await isarInstance.tBItems.put(i);
      currentItem.boardItems.add(i);
      await currentItem.boardItems.save();
      await i.parentItem.save();
    });
    watchChild(id);

    return id;
  }

  Future<int> addItem(TBItem item) async {
    var i = item;
    var id = -1;
    await isarInstance.writeTxn(() async {
      id = await isarInstance.tBItems.put(i);
    });
    watchChild(id);
    notifyListeners();
    return id;
  }

  Future<int> moveItem(TBItem dest, TBItem item) async {
    var id = -1;
    var parentItem = item.parentItem.value!;
    await isarInstance.writeTxn(() async {
      item.parentItem.value = dest;
      item.parentItem.save();
      item.column = dest.boardColumns.first.name;
      id = await isarInstance.tBItems.put(item);
      parentItem.boardItems.remove(item);
      parentItem.boardItems.save();
      dest.boardItems.add(item);
      dest.boardItems.save();
    });
    watchChild(id);
    notifyListeners();
    return id;
  }

  Future<int> toggleViewType(bool value) async {
    var i = currentItem;
    i.viewType = (value) ? "List" : "Board";
    var id = -1;
    await isarInstance.writeTxn(() async {
      id = await isarInstance.tBItems.put(i);
    });
    return id;
  }

  Future<int> editItemText(int itemId, String text) async {
    var item = await getItemFromId(itemId);
    var id = -1;
    if (item != null) {
      item.text = text;
      await isarInstance.writeTxn(() async {
        id = await isarInstance.tBItems.put(item);
      });
    }

    return id;
  }

  Future<int> addItemWithColumns(
      TBItem item, String oldValue, String newValue) async {
    var i = item;
    var id = -1;
    await isarInstance.writeTxn(() async {
      id = await isarInstance.tBItems.put(i);
      for (var element in item.boardItems) {
        if (element.column == oldValue) {
          element.column = newValue;
        }
        await isarInstance.tBItems.put(element);
      }
    });
    watchChild(id);

    return id;
  }

  Future<TBItem?> getItemFromId(int id) async {
    return await isarInstance.tBItems.where().idEqualTo(id).findFirst();
  }

  Future<void> deleteItemRecursivily(TBItem item) async {
    if (item.boardItems.isEmpty) {
      await isarInstance.writeTxn(() async {
        await isarInstance.tBItems.delete(item.id);
      });
    } else {
      for (var i in item.boardItems) {
        deleteItemRecursivily(i);
      }
      await isarInstance.writeTxn(() async {
        await isarInstance.tBItems.delete(item.id);
      });
    }
  }

  Future<int> addColumn(int index, TBColumn column) async {
    var parentColumns = currentItem.boardColumns;
    var length = parentColumns.length;
    List<TBColumn> columns = [
      ...parentColumns.getRange(0, index),
      column,
      ...parentColumns.getRange(index, length)
    ];
    currentItem.boardColumns = columns;
    var id = -1;
    await isarInstance.writeTxn(() async {
      id = await isarInstance.tBItems.put(currentItem);
    });

    return id;
  }

  Future<int> removeColumn(int index) async {
    var parentColumns = currentItem.boardColumns;
    var columns = parentColumns
        .where((element) => element != parentColumns[index])
        .toList();
    currentItem.boardColumns = columns;
    var id = -1;
    await isarInstance.writeTxn(() async {
      id = await isarInstance.tBItems.put(currentItem);
    });

    return id;
  }

  Future<void> moveItemToColumnFromId(int id, String toColumn) async {
    var item = await getItemFromId(id);
    if (item != null) {
      await moveItemToColumn(item, toColumn);
    }
  }

  Future<void> moveItemToColumn(TBItem i, String toColumn) async {
    var fromColumn = i.column;
    i.order = currentItem.boardItems
        .toList()
        .where((element) => element.column == toColumn)
        .length;
    i.column = toColumn;
    await isarInstance.writeTxn(() async {
      await isarInstance.tBItems.put(i);
    });

    var updatingItems = currentItem.boardItems
        .toList()
        .where((element) => element.column == fromColumn && element.id != i.id)
        .toList();

    for (int i = 0; i < updatingItems.length; i++) {
      updatingItems[i].order = i;
    }

    await isarInstance.writeTxn(() async {
      await isarInstance.tBItems.putAll(updatingItems);
    });
  }
}
