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
  void addToList(String text) {
    final newItem = ShoppingItemModel(
      id: UniqueKey().hashCode,
      isChecked: false,
      name: text,
    );
    shoppingItemsBox?.add(newItem);
    shoppingItems?.add(newItem);
  }

  // void addToList(String text) {
  //   shoppingItems = ObservableList.of(shoppingItems ?? [])
  //     ..add(ShoppingItemModel(
  //       id: UniqueKey().hashCode,
  //       isChecked: false,
  //       name: text,
  //     ));
  // }

  @action
  removeFromList(ShoppingItemModel item) {
    shoppingItemsBox?.delete(item.key);
    shoppingItems?.removeWhere((e) => e.id == item.id);
  }

  @action
  addToListAfterItemCheck(ShoppingItemModel item) {
    int end = shoppingItems!.length;

    shoppingItems = ObservableList.of(shoppingItems ?? [])..insert(end, item);
  }

  @action
  addToListAfterItemUncheck(ShoppingItemModel item) {
    shoppingItems = ObservableList.of(shoppingItems ?? [])..insert(0, item);
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
