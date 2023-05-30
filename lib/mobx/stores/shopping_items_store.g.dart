// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_items_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ShoppingItemsStore on ShoppingItemsStoreBase, Store {
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

  late final _$ShoppingItemsStoreBaseActionController =
      ActionController(name: 'ShoppingItemsStoreBase', context: context);

  @override
  void addToList(String text) {
    final _$actionInfo = _$ShoppingItemsStoreBaseActionController.startAction(
        name: 'ShoppingItemsStoreBase.addToList');
    try {
      return super.addToList(text);
    } finally {
      _$ShoppingItemsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeFromList(ShoppingItemModel item) {
    final _$actionInfo = _$ShoppingItemsStoreBaseActionController.startAction(
        name: 'ShoppingItemsStoreBase.removeList');
    try {
      return super.removeFromList(item);
    } finally {
      _$ShoppingItemsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
shoppingItems: ${shoppingItems}
    ''';
  }
}
