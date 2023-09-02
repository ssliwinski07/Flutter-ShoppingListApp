import 'package:flutter/material.dart';
import 'package:shopping_reminder/core/services/message_info_service/message_service_info.dart';
import 'package:shopping_reminder/helpers/enums.dart';
import 'package:shopping_reminder/mobx/stores/shopping_items_store.dart';
import 'package:shopping_reminder/models/shopping_item_model.dart';
import 'package:shopping_reminder/res/colors/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:shopping_reminder/widgets/items_manipulation_widget/items_manipulation_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

class ShoppingListItem extends StatefulWidget {
  const ShoppingListItem({
    super.key,
    this.shoppingItem,
  });

  final ShoppingItemModel? shoppingItem;

  @override
  State<ShoppingListItem> createState() => _ShoppingListItemState();
}

class _ShoppingListItemState extends State<ShoppingListItem> {
  bool _isTappedForDeletion = false;
  ShoppingItemModel get _item => widget.shoppingItem!;
  bool get _isItemChecked => widget.shoppingItem!.isChecked;

  final MessageInfoService _messageService =
      GetIt.instance<MessageInfoService>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.red,
          child: AnimatedContainer(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            duration: const Duration(milliseconds: 400),
            child: Padding(
              padding: const EdgeInsets.only(right: 80),
              child: ListTile(
                leading: _isTappedForDeletion
                    ? _getDeleteIcon()
                    : _getCheckIcon(context),
                title: GestureDetector(
                  onLongPress: _isTappedForDeletion
                      ? null
                      : () {
                          _showUpdateItemDialog(
                            shouldHideDialog: true,
                            context: context,
                          );
                        },
                  onTap: () {
                    setState(() {});
                    _isTappedForDeletion = !_isTappedForDeletion;
                  },
                  child: Text(
                    widget.shoppingItem!.name,
                    maxLines: 100,
                    style: TextStyle(
                      color: _isItemChecked ? Colors.grey : Colors.black,
                      decoration:
                          _isItemChecked ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _showUpdateItemDialog(
      {bool? shouldHideDialog = true, BuildContext? context}) {
    showDialog(
      context: context!,
      builder: (context) => ItemsManipulationWidget(
        shouldHideDialog: shouldHideDialog,
        shoppingItem: widget.shoppingItem,
        itemManipulationType: ItemManipulationType.update,
        onTap: (text) {
          Provider.of<ShoppingItemsStore>(context, listen: false)
              .updateItem(widget.shoppingItem!, text);
        },
      ),
    );
  }

  _getDeleteIcon() {
    return GestureDetector(
      onTap: () {
        try {
          Provider.of<ShoppingItemsStore>(context, listen: false)
              .removeFromList(_item);
          _isTappedForDeletion = !_isTappedForDeletion;
          _messageService.showMessage(
              context: context,
              infoType: InfoTypes.info,
              infoMessage: AppLocalizations.of(context).itemDeleted);
        } catch (e) {
          _messageService.showMessage(
            context: context,
            infoMessage: AppLocalizations.of(context).errorMessage,
            infoType: InfoTypes.alert,
          );
        }
      },
      child: const Icon(
        Icons.remove,
        color: Colors.red,
      ),
    );
  }

  _getCheckIcon(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_isItemChecked == false) {
          try {
            Provider.of<ShoppingItemsStore>(context, listen: false)
                .itemCheck(_item);
          } catch (e) {
            _messageService.showMessage(
              infoMessage: AppLocalizations.of(context).errorMessage,
              infoType: InfoTypes.alert,
              context: context,
            );
          }
        } else {
          try {
            Provider.of<ShoppingItemsStore>(context, listen: false)
                .unCheckItem(_item);
          } catch (e) {
            _messageService.showMessage(
                infoMessage: AppLocalizations.of(context).errorMessage,
                infoType: InfoTypes.alert);
          }
        }
      },
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _isItemChecked ? AppColors.green : null,
          border: Border.all(
            width: 1,
            color: AppColors.green,
          ),
        ),
        child: _isItemChecked
            ? const Icon(
                Icons.check,
                color: Colors.white,
              )
            : const SizedBox(),
      ),
    );
  }
}
