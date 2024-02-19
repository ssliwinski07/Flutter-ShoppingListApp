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
  void getAllItems() {
    countAllItems = shoppingItemsBox!.length;
  }

  @action
  void getCheckedItems() {
    int count = 0;
    var list = Hive.box<ShoppingItemModel>('shoppingItems').values.toList();
    for (ShoppingItemModel item in list) {
      if (item.isChecked == true) {
        count++;
      }
    }
    countCheckedItems = count;
  }

  @action
  Future<void> updateItem(ShoppingItemModel item, String text) async {
    item.name = text;
    if (item.isChecked == true) {
      item.isChecked = false;
     getCheckedItems();
    }

    await shoppingItemsBox?.put(item.key, item);
  }

  @action
  Future<void> addToList(String text) async {
    final newItem = ShoppingItemModel(
      id: UniqueKey().hashCode,
      isChecked: false,
      name: text,
    );
    await shoppingItemsBox?.add(newItem);
    getAllItems();
  }

  @action
  Future<void> removeFromList(ShoppingItemModel item) async {
    await shoppingItemsBox?.delete(item.key);
    getCheckedItems();
    getAllItems();
  }

  @action
  Future<void> itemCheck(ShoppingItemModel item) async {
    item.isChecked = true;
    await shoppingItemsBox?.put(item.key, item);
    getCheckedItems();
  }

  @action
  Future<void> unCheckItem(ShoppingItemModel item) async {
    item.isChecked = false;
    await shoppingItemsBox?.put(item.key, item);
    getCheckedItems();
  }

  @action
  Future<void> deleteAllItems() async {
    await shoppingItemsBox?.clear();
    getCheckedItems();
    getAllItems();
  }

  Future<void> initHive() async {
    await Hive.openBox<ShoppingItemModel>('shoppingItems');
    shoppingItemsBox = Hive.box<ShoppingItemModel>('shoppingItems');
    shoppingItems =
        ObservableList<ShoppingItemModel>.of(shoppingItemsBox!.values.toList());
    shoppingItemsBox!.watch().listen((event) {
      shoppingItems = ObservableList<ShoppingItemModel>.of(
          shoppingItemsBox!.values.toList());
    });
  }
}
