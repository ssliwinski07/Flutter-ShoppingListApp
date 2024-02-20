import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

import 'package:shopping_reminder/core/core.dart';
import 'package:shopping_reminder/helpers/helpers.dart';
import 'package:shopping_reminder/mobx/stores.dart';
import 'package:shopping_reminder/models/models.dart';
import 'package:shopping_reminder/res/res.dart';
import 'package:shopping_reminder/widgets/widgets.dart';
import 'package:shopping_reminder/extensions/extensions.dart';

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

  late final ShoppingItemsStore _store;

  MessageInfoService get _messageService =>
      GetIt.instance<MessageInfoService>();

  @override
  void initState() {
    super.initState();
    _store = Provider.of<ShoppingItemsStore>(context, listen: false);
  }

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
                    ? _getDeleteIcon(context: context, store: _store)
                    : _getCheckIcon(
                        context: context,
                        store: _store,
                      ),
                title: GestureDetector(
                  onLongPress: _isTappedForDeletion
                      ? null
                      : () {
                          _showUpdateItemDialog(
                            shouldHideDialog: true,
                            context: context,
                            store: _store,
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
      {bool? shouldHideDialog = true,
      BuildContext? context,
      required ShoppingItemsStore store}) {
    showDialog(
      context: context!,
      builder: (context) => ItemsManipulationWidget(
        shouldHideDialog: shouldHideDialog,
        shoppingItem: widget.shoppingItem,
        itemManipulationType: ItemManipulationType.update,
        onTap: (text) {
          store.updateItem(widget.shoppingItem!, text);
        },
      ),
    );
  }

  _getDeleteIcon({
    required ShoppingItemsStore store,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () {
        try {
          store.removeFromList(_item);
          _isTappedForDeletion = !_isTappedForDeletion;
          _messageService.showMessage(
              context: context,
              infoType: InfoTypes.info,
              infoMessage: context.translate.itemDeleted);
        } catch (e) {
          _messageService.showMessage(
            context: context,
            infoMessage: context.translate.errorMessage,
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

  _getCheckIcon(
      {required BuildContext context, required ShoppingItemsStore store}) {
    return GestureDetector(
      onTap: () {
        if (_isItemChecked == false) {
          try {
            store.itemCheck(_item);
          } catch (e) {
            _messageService.showMessage(
              infoMessage: context.translate.errorMessage,
              infoType: InfoTypes.alert,
              context: context,
            );
          }
        } else {
          try {
            store.unCheckItem(_item);
          } catch (e) {
            _messageService.showMessage(
                infoMessage: context.translate.errorMessage,
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
