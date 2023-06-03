import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:hive/hive.dart';
import 'package:shopping_reminder/models/shopping_item_model.dart';

part 'shopping_items_store.g.dart';

class ShoppingItemsStore = ShoppingItemsStoreBase with _$ShoppingItemsStore;

abstract class ShoppingItemsStoreBase with Store {
  ShoppingItemsStoreBase() {
    initHive();
  }

  Box<ShoppingItemModel>? shoppingItemsBox;

  @observable
  int countAllItems = 0;

  @observable
  int countCheckedItems = 0;

  @observable
  List<ShoppingItemModel>? shoppingItems = [];

  @action
  getAllItems() {
    countAllItems = shoppingItemsBox!.length;
    return countAllItems;
  }

  @action
  getCheckedItems() {
    int count = 0;
    var list = Hive.box<ShoppingItemModel>('shoppingItems').values.toList();
    for (ShoppingItemModel item in list) {
      if (item.isChecked == true) {
        count++;
      }
    }
    countCheckedItems = count;
    return countCheckedItems;
  }

  @action
  addToList(String text) async {
    final newItem = ShoppingItemModel(
      id: UniqueKey().hashCode,
      isChecked: false,
      name: text,
    );
    await shoppingItemsBox?.add(newItem);
    getAllItems();
  }

  @action
  removeFromList(ShoppingItemModel item) async {
    await shoppingItemsBox?.delete(item.key);
    await getCheckedItems();
    await getAllItems();
  }

  @action
  itemCheck(ShoppingItemModel item) async {
    item.isChecked = true;
    shoppingItemsBox?.put(item.key, item);
    await getCheckedItems();
  }

  @action
  unCheckItem(ShoppingItemModel item) async {
    item.isChecked = false;
    shoppingItemsBox?.put(item.key, item);
    await getCheckedItems();
  }

  @action
  deleteAllItems() async {
    await shoppingItemsBox?.clear();
  }

  Future<void> initHive() async {
    shoppingItemsBox = Hive.box<ShoppingItemModel>('shoppingItems');
    shoppingItems =
        ObservableList<ShoppingItemModel>.of(shoppingItemsBox!.values.toList());
    shoppingItemsBox!.watch().listen((event) {
      shoppingItems = ObservableList<ShoppingItemModel>.of(
          shoppingItemsBox!.values.toList());
    });
  }
}
