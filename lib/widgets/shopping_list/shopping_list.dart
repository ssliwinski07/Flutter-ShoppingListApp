import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:shopping_reminder/helpers/helpers.dart';
import 'package:shopping_reminder/mobx/stores.dart';
import 'package:shopping_reminder/res/res.dart';
import 'package:shopping_reminder/widgets/widgets.dart';
import 'package:shopping_reminder/extensions/extensions.dart';

class ShoppingList extends StatelessWidget {
  const ShoppingList({super.key});

  @override
  Widget build(BuildContext context) {
    ShoppingItemsStore store =
        Provider.of<ShoppingItemsStore>(context, listen: false);
    return Observer(
      builder: (_) => store.shoppingItems == null ||
              store.shoppingItems!.isEmpty
          ? NoContentInfoWidget(
              isAddingButtonVisible: true,
              onTap: () {
                _showAddingItemDialog(
                  context: context,
                  store: store,
                );
              })
          : Stack(
              children: [
                Observer(
                  builder: (_) => ListView.builder(
                    padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                    physics: const BouncingScrollPhysics(),
                    itemCount: store.shoppingItems!.length,
                    itemBuilder: (BuildContext context, int index) {
                      var item = store.shoppingItems?[index];
                      return ShoppingListItem(
                        shoppingItem: item,
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 130.0,
                  right: 40.0,
                  child: SRButton(
                    width: 60,
                    height: 60,
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      _showAddingItemDialog(
                        shouldHideDialog: false,
                        context: context,
                        store: store,
                      );
                    },
                    color: AppColors.green,
                    buttonTitle: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 40.0,
                  right: 40.0,
                  child: SRButton(
                    width: 60,
                    height: 60,
                    borderRadius: BorderRadius.circular(30),
                    onTap: () => _showInfoAlertWidget(context, store: store),
                    color: AppColors.green,
                    buttonTitle: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  _showAddingItemDialog({
    bool? shouldHideDialog = true,
    BuildContext? context,
    required ShoppingItemsStore store,
  }) {
    showDialog(
      context: context!,
      builder: (context) => ItemsManipulationWidget(
        shouldHideDialog: shouldHideDialog,
        itemManipulationType: ItemManipulationType.add,
        onTap: (text) {
          store.addToList(text);
        },
      ),
    );
  }

  _showInfoAlertWidget(
    BuildContext? context, {
    required ShoppingItemsStore store,
  }) {
    showDialog(
      context: context!,
      builder: (context) => InfoAlertWidget(
        onTap: () {
          store.deleteAllItems();
        },
        infoTitle: context.translate.areYouSure,
        leftInfoButtonTitle: context.translate.confirm,
        rightInfoButtonTitle: context.translate.cancel,
      ),
    );
  }
}
