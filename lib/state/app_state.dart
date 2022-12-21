import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:taskboard/models/isar_models/item.dart';

class AppState with ChangeNotifier {
  late Isar isarInstance;
  Item parentItem = Item('', '', -1);

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
        var i = Item('Main', defaultColumns[0], -1);
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

  Future<int> addItem(String context) async {
    var column = parentItem.boardColumns.first;
    var order = parentItem.boardItems
        .toList()
        .where((element) => element.column == column)
        .length;
    var i = Item(context, column, order);
    i.parentItem.value = parentItem;
    i.boardName = context;
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

  Future<int> addColumn(int index, String column) async {
    var parentColumns = parentItem.boardColumns;
    var length = parentColumns.length;
    var columns = [
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
