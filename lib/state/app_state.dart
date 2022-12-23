import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:taskboard/models/isar_models/tb_column.dart';
import 'package:taskboard/models/isar_models/tb_item.dart';

class AppState with ChangeNotifier {
  late Isar isarInstance;
  TextEditingController cliController = TextEditingController();

  late TBItem parentItem;
  late List<TBItem> childItems;

  static final TBItem badItem = TBItem("Item not found :(", "", 0);

  AppState(Isar isarInsatnce, TBItem? mainItem) {
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
    isarInstance.tBItems
        .watchObject(parentItem.id, fireImmediately: true)
        .listen(
      (event) async {
        parentItem = (await isarInstance.tBItems
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
    isarInstance.tBItems.watchObject(id, fireImmediately: true).listen(
      (event) async {
        parentItem = (await isarInstance.tBItems
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

  Future<void> setBoard(TBItem item) async {
    parentItem = (await isarInstance.tBItems
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
    TBItem? pointer = parentItem;
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
    var i = TBItem(text, column, order);
    i.parentItem.value = parentItem;
    i.boardName = text;
    var id = -1;
    await isarInstance.writeTxn(() async {
      id = await isarInstance.tBItems.put(i);
      parentItem.boardItems.add(i);
      await parentItem.boardItems.save();
      await i.parentItem.save();
    });
    watchItem(id);
    notifyListeners();
    return id;
  }

  Future<int> addItem(TBItem item) async {
    var i = item;
    var id = -1;
    await isarInstance.writeTxn(() async {
      id = await isarInstance.tBItems.put(i);
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
        id = await isarInstance.tBItems.put(item);
      });
    }
    notifyListeners();
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
    watchItem(id);
    notifyListeners();
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
    notifyListeners();
  }

  Future<int> addColumn(int index, TBColumn column) async {
    var parentColumns = parentItem.boardColumns;
    var length = parentColumns.length;
    List<TBColumn> columns = [
      ...parentColumns.getRange(0, index),
      column,
      ...parentColumns.getRange(index, length)
    ];
    parentItem.boardColumns = columns;
    var id = -1;
    await isarInstance.writeTxn(() async {
      id = await isarInstance.tBItems.put(parentItem);
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
      id = await isarInstance.tBItems.put(parentItem);
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

  Future<void> moveItemToColumn(TBItem i, String toColumn) async {
    var fromColumn = i.column;
    i.order = parentItem.boardItems
        .toList()
        .where((element) => element.column == toColumn)
        .length;
    i.column = toColumn;
    await isarInstance.writeTxn(() async {
      await isarInstance.tBItems.put(i);
    });

    var updatingItems = parentItem.boardItems
        .toList()
        .where((element) => element.column == fromColumn && element.id != i.id)
        .toList();

    for (int i = 0; i < updatingItems.length; i++) {
      updatingItems[i].order = i;
    }

    await isarInstance.writeTxn(() async {
      await isarInstance.tBItems.putAll(updatingItems);
    });

    notifyListeners();
  }
}
