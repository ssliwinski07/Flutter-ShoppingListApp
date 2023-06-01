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
  List<ShoppingItemModel>? shoppingItems = [];

  @action
  addToList(String text) {
    final newItem = ShoppingItemModel(
      id: UniqueKey().hashCode,
      isChecked: false,
      name: text,
    );
    shoppingItemsBox?.add(newItem);
  }

  @action
  removeFromList(ShoppingItemModel item) {
    shoppingItemsBox?.delete(item.key);
  }

  @action
  itemCheck(ShoppingItemModel item) {
    item.isChecked = true;
    shoppingItemsBox?.put(item.key, item);
  }

  @action
  unCheckItem(ShoppingItemModel item) {
    item.isChecked = false;
    shoppingItemsBox?.put(item.key, item);
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
