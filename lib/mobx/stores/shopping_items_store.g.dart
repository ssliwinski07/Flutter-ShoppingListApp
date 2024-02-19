// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_items_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ShoppingItemsStore on ShoppingItemsStoreBase, Store {
  late final _$countAllItemsAtom =
      Atom(name: 'ShoppingItemsStoreBase.countAllItems', context: context);

  @override
  int get countAllItems {
    _$countAllItemsAtom.reportRead();
    return super.countAllItems;
  }

  @override
  set countAllItems(int value) {
    _$countAllItemsAtom.reportWrite(value, super.countAllItems, () {
      super.countAllItems = value;
    });
  }

  late final _$countCheckedItemsAtom =
      Atom(name: 'ShoppingItemsStoreBase.countCheckedItems', context: context);

  @override
  int get countCheckedItems {
    _$countCheckedItemsAtom.reportRead();
    return super.countCheckedItems;
  }

  @override
  set countCheckedItems(int value) {
    _$countCheckedItemsAtom.reportWrite(value, super.countCheckedItems, () {
      super.countCheckedItems = value;
    });
  }

  late final _$shoppingItemsAtom =
      Atom(name: 'ShoppingItemsStoreBase.shoppingItems', context: context);

  @override
  List<ShoppingItemModel>? get shoppingItems {
    _$shoppingItemsAtom.reportRead();
    return super.shoppingItems;
  }

  @override
  set shoppingItems(List<ShoppingItemModel>? value) {
    _$shoppingItemsAtom.reportWrite(value, super.shoppingItems, () {
      super.shoppingItems = value;
    });
  }

  late final _$updateItemAsyncAction =
      AsyncAction('ShoppingItemsStoreBase.updateItem', context: context);

  @override
  Future<void> updateItem(ShoppingItemModel item, String text) {
    return _$updateItemAsyncAction.run(() => super.updateItem(item, text));
  }

  late final _$addToListAsyncAction =
      AsyncAction('ShoppingItemsStoreBase.addToList', context: context);

  @override
  Future<void> addToList(String text) {
    return _$addToListAsyncAction.run(() => super.addToList(text));
  }

  late final _$removeFromListAsyncAction =
      AsyncAction('ShoppingItemsStoreBase.removeFromList', context: context);

  @override
  Future<void> removeFromList(ShoppingItemModel item) {
    return _$removeFromListAsyncAction.run(() => super.removeFromList(item));
  }

  late final _$itemCheckAsyncAction =
      AsyncAction('ShoppingItemsStoreBase.itemCheck', context: context);

  @override
  Future<void> itemCheck(ShoppingItemModel item) {
    return _$itemCheckAsyncAction.run(() => super.itemCheck(item));
  }

  late final _$unCheckItemAsyncAction =
      AsyncAction('ShoppingItemsStoreBase.unCheckItem', context: context);

  @override
  Future<void> unCheckItem(ShoppingItemModel item) {
    return _$unCheckItemAsyncAction.run(() => super.unCheckItem(item));
  }

  late final _$deleteAllItemsAsyncAction =
      AsyncAction('ShoppingItemsStoreBase.deleteAllItems', context: context);

  @override
  Future<void> deleteAllItems() {
    return _$deleteAllItemsAsyncAction.run(() => super.deleteAllItems());
  }

  late final _$ShoppingItemsStoreBaseActionController =
      ActionController(name: 'ShoppingItemsStoreBase', context: context);

  @override
  void getAllItems() {
    final _$actionInfo = _$ShoppingItemsStoreBaseActionController.startAction(
        name: 'ShoppingItemsStoreBase.getAllItems');
    try {
      return super.getAllItems();
    } finally {
      _$ShoppingItemsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getCheckedItems() {
    final _$actionInfo = _$ShoppingItemsStoreBaseActionController.startAction(
        name: 'ShoppingItemsStoreBase.getCheckedItems');
    try {
      return super.getCheckedItems();
    } finally {
      _$ShoppingItemsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
countAllItems: ${countAllItems},
countCheckedItems: ${countCheckedItems},
shoppingItems: ${shoppingItems}
    ''';
  }
}
