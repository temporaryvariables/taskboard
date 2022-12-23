import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:taskboard/models/isar_models/isar_column.dart';
import 'package:taskboard/models/isar_models/item.dart';

class AppState with ChangeNotifier {
  late Isar isarInstance;
  TextEditingController cliController = TextEditingController();

  late Item parentItem;
  late List<Item> childItems;

  static final Item badItem = Item("Item not found :(", "", 0);

  AppState(Isar isarInsatnce, Item? mainItem) {
    isarInstance = isarInsatnce;
    parentItem = mainItem ?? badItem;
    childItems = parentItem.boardItems.toList();

    cliController.addListener(() {
      notifyListeners();
    });

    reWatch();
  }

  void reWatch() {
    watchParent();
    watchChildren();
  }

  void watchParent() {
    isarInstance.items.watchObject(parentItem.id, fireImmediately: true).listen(
      (event) async {
        parentItem = (await isarInstance.items
                .where()
                .filter()
                .idEqualTo(parentItem.id)
                .findFirst()) ??
            badItem;
        childItems = parentItem.boardItems.toList();
        notifyListeners();
      },
    );
  }

  void watchItem(int id) {
    isarInstance.items.watchObject(id, fireImmediately: true).listen(
      (event) async {
        parentItem = (await isarInstance.items
                .where()
                .filter()
                .idEqualTo(parentItem.id)
                .findFirst()) ??
            badItem;
        childItems = parentItem.boardItems.toList();
        notifyListeners();
      },
    );
  }

  void watchChildren() {
    for (var children in parentItem.boardItems) {
      watchItem(children.id);
    }
  }

  Future<void> setBoard(Item item) async {
    parentItem = (await isarInstance.items
            .where()
            .filter()
            .idEqualTo(item.id)
            .findFirst()) ??
        badItem;
    childItems = parentItem.boardItems.toList();

    reWatch();
    notifyListeners();
  }

  String getFullPath() {
    Item? pointer = parentItem;
    String path = "";
    while (pointer != null) {
      path = "\\${pointer.boardName}$path";
      pointer = pointer.parentItem.value;
    }
    return path;
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
    watchItem(id);
    notifyListeners();
    return id;
  }

  Future<int> addItem(Item item) async {
    var i = item;
    var id = -1;
    await isarInstance.writeTxn(() async {
      id = await isarInstance.items.put(i);
    });
    watchItem(id);
    notifyListeners();
    return id;
  }

  Future<int> editItemText(int itemId, String text) async {
    var item = await getItemFromId(itemId);
    var id = -1;
    if (item != null) {
      item.text = text;
      await isarInstance.writeTxn(() async {
        id = await isarInstance.items.put(item);
      });
    }
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
    watchItem(id);
    notifyListeners();
    return id;
  }

  Future<Item?> getItemFromId(int id) async {
    return await isarInstance.items.where().idEqualTo(id).findFirst();
  }

  Future<void> deleteItemRecursivily(Item item) async {
    if (item.boardItems.isEmpty) {
      await isarInstance.writeTxn(() async {
        await isarInstance.items.delete(item.id);
      });
    } else {
      for (var i in item.boardItems) {
        deleteItemRecursivily(i);
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

  Future<void> moveItemToColumnFromId(int id, String toColumn) async {
    var item = await getItemFromId(id);
    if (item != null) {
      await moveItemToColumn(item, toColumn);
    }
  }

  Future<void> moveItemToColumn(Item i, String toColumn) async {
    // set new order
    var fromColumn = i.column;
    i.order = parentItem.boardItems
        .toList()
        .where((element) => element.column == toColumn)
        .length;
    i.column = toColumn;
    await isarInstance.writeTxn(() async {
      // * does this automatically change link value as well? Yes it does!
      await isarInstance.items.put(i);
      // await i.parentItem.value!.boardItems.save();
    });

    // reset order of old tasks
    var updatingItems = parentItem.boardItems
        .toList()
        .where((element) => element.column == fromColumn && element.id != i.id)
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
