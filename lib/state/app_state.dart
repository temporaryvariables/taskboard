import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:taskboard/models/isar_models/isar_column.dart';
import 'package:taskboard/models/isar_models/item.dart';

class AppState with ChangeNotifier {
  late Isar isarInstance;
  Item parentItem = Item("Default", '', -1);

  AppState(Isar i) {
    isarInstance = i;
  }

  // this function is always run once on load
  Future<bool> setInitialItem(Item? i) async {
    if (i != null) {
      parentItem = (await isarInstance.items
          .where()
          .filter()
          .idEqualTo(i.id)
          .findFirst())!;
    } else {
      var count = await isarInstance.getSize();
      if (count == 0) {
        // -1 order signifies main item
        var i = Item("Main", "Backlog", -1);
        i.boardName = "Main";
        await isarInstance.writeTxn(() async {
          await isarInstance.items.put(i);
        });
      }
      parentItem = (await isarInstance.items
          .where()
          .filter()
          .orderEqualTo(-1)
          .findFirst())!;
    }
    notifyListeners();
    return true;
  }

  Future<int> addItemWithText(String text) async {
    var column = parentItem.boardColumns.first.name;
    var order = parentItem.boardItems
        .toList()
        .where((element) => element.column == column)
        .length;
    var i = Item(text, column, order);
    i.parentItem.value = parentItem;
    i.boardName = text;
    var id = -1;
    await isarInstance.writeTxn(() async {
      id = await isarInstance.items.put(i);
      parentItem.boardItems.add(i);
      await parentItem.boardItems.save();
      await i.parentItem.save();
    });
    notifyListeners();
    return id;
  }

  Future<int> addItem(Item item) async {
    var i = item;
    var id = -1;
    await isarInstance.writeTxn(() async {
      id = await isarInstance.items.put(i);
    });
    notifyListeners();
    return id;
  }

  Future<int> addItemWithColumns(
      Item item, String oldValue, String newValue) async {
    var i = item;
    var id = -1;
    await isarInstance.writeTxn(() async {
      id = await isarInstance.items.put(i);
      for (var element in item.boardItems) {
        if (element.column == oldValue) {
          element.column = newValue;
        }
        await isarInstance.items.put(element);
      }
    });
    notifyListeners();
    return id;
  }

  Future<void> deleteItem(Item item) async {
    if (item.boardItems.isEmpty) {
      await isarInstance.writeTxn(() async {
        await isarInstance.items.delete(item.id);
      });
    } else {
      for (var i in item.boardItems) {
        deleteItem(i);
      }
      await isarInstance.writeTxn(() async {
        await isarInstance.items.delete(item.id);
      });
    }
    notifyListeners();
  }

  Future<int> addColumn(int index, IsarColumn column) async {
    var parentColumns = parentItem.boardColumns;
    var length = parentColumns.length;
    List<IsarColumn> columns = [
      ...parentColumns.getRange(0, index),
      column,
      ...parentColumns.getRange(index, length)
    ];
    parentItem.boardColumns = columns;
    var id = -1;
    await isarInstance.writeTxn(() async {
      id = await isarInstance.items.put(parentItem);
    });
    notifyListeners();
    return id;
  }

  Future<int> removeColumn(int index) async {
    var parentColumns = parentItem.boardColumns;
    var columns = parentColumns
        .where((element) => element != parentColumns[index])
        .toList();
    parentItem.boardColumns = columns;
    var id = -1;
    await isarInstance.writeTxn(() async {
      id = await isarInstance.items.put(parentItem);
    });
    notifyListeners();
    return id;
  }

  Future<void> moveItemToColumn(
      Item i, String fromColumn, String toColumn) async {
    // set new order
    i.order = parentItem.boardItems
        .toList()
        .where((element) => element.column == toColumn)
        .length;
    i.column = toColumn;
    await isarInstance.writeTxn(() async {
      // * does this automatically change link value as well? Yes it does!
      await isarInstance.items.put(i);
    });

    // reset order of old tasks
    var updatingItems = parentItem.boardItems
        .toList()
        .where((element) => element.column == fromColumn)
        .toList();

    for (int i = 0; i < updatingItems.length; i++) {
      updatingItems[i].order = i;
    }

    await isarInstance.writeTxn(() async {
      await isarInstance.items.putAll(updatingItems);
    });

    notifyListeners();
  }
}
