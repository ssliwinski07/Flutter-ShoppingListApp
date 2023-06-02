import 'package:flutter/material.dart';

import 'package:shopping_reminder/mobx/stores/shopping_items_store.dart';
import 'package:shopping_reminder/res/colors/app_colors.dart';
import 'package:shopping_reminder/widgets/adding_items_widget/adding_items_widget.dart';
import 'package:shopping_reminder/widgets/alert_info_widget/info_alert_widget.dart';
import 'package:shopping_reminder/widgets/buttons/action_buttons/sr_button.dart';
import 'package:shopping_reminder/widgets/no_content_info_widget/no_content_widget.dart';
import 'package:shopping_reminder/widgets/shopping_list/shopping_list_item.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({super.key, this.shoppingItemStore});

  final ShoppingItemsStore? shoppingItemStore;

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return widget.shoppingItemStore!.shoppingItems == null ||
                widget.shoppingItemStore!.shoppingItems!.isEmpty
            ? NoContentInfoWidget(
                isAddingButtonVisible: true,
                onTap: _showAddingItemDialog,
              )
            : SizedBox(
                height: 400,
                child: Stack(
                  children: [
                    Observer(
                      builder: (_) => ListView.builder(
                        padding: const EdgeInsets.only(bottom: 10.0, top: 5.0),
                        physics: const BouncingScrollPhysics(),
                        itemCount:
                            widget.shoppingItemStore!.shoppingItems!.length,
                        itemBuilder: (BuildContext context, int index) {
                          var item =
                              widget.shoppingItemStore!.shoppingItems?[index];
                          return ShoppingListItem(
                            shoppingItem: item,
                            store: widget.shoppingItemStore,
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
                        onTap: _showAddingItemDialog,
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
                        onTap: _showInfoAlertWidget,
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
      },
    );
  }

  _showAddingItemDialog() {
    showDialog(
      context: context,
      builder: (context) => AddingItemsWidget(
        store: widget.shoppingItemStore,
      ),
    );
  }

  _showInfoAlertWidget() {
    showDialog(
      context: context,
      builder: (context) => InfoAlertWidget(
        onTap: () {
          widget.shoppingItemStore!.deleteAllItems();
        },
        infoTitle: AppLocalizations.of(context).areYouSure,
        leftInfoButtonTitle: AppLocalizations.of(context).confirm,
        rightInfoButtonTitle: AppLocalizations.of(context).cancel,
      ),
    );
  }
}
