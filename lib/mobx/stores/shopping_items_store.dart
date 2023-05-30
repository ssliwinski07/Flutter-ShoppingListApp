import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shopping_reminder/models/shopping_item_model.dart';

part 'shopping_items_store.g.dart';

class ShoppingItemsStore = ShoppingItemsStoreBase with _$ShoppingItemsStore;

abstract class ShoppingItemsStoreBase with Store {
  @observable
  List<ShoppingItemModel>? shoppingItems = [];

  @action
  void addToList(String text) {
    shoppingItems = ObservableList.of(shoppingItems ?? [])
      ..add(ShoppingItemModel(
          id: UniqueKey().hashCode, isChecked: false, name: text));
  }

  @action
  void removeFromList(ShoppingItemModel item) {
    shoppingItems?.removeWhere((e) => e.id == item.id);
  }

  @action
  void addAgain(ShoppingItemModel item) {
    int end = shoppingItems!.length;

    shoppingItems = ObservableList.of(shoppingItems ?? [])..insert(end, item);
  }

  @action
  void addAgain2(ShoppingItemModel item, {int? index}) {
    shoppingItems = ObservableList.of(shoppingItems ?? [])..insert(0, item);
  }
}
