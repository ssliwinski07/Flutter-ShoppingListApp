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
      ..add(ShoppingItemModel(id: UniqueKey().hashCode, name: text));
  }

  @action
  void removeFromList(ShoppingItemModel item) {
    shoppingItems?.removeWhere((e) => e.id == item.id);
  }
}
