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
    return CustomListTile(
      leading: _isTappedForDeletion
          ? _GetDeleteIcon(
              shoppingItemStore: _store,
              item: _item,
              messageInfoService: _messageService,
              onTapCallback: (isTappedForDeletion) {
                _isTappedForDeletion = isTappedForDeletion;
              },
            )
          : _GetCheckIcon(
              isItemChecked: _isItemChecked,
              shoppingItemsStore: _store,
              messageInfoService: _messageService,
              item: _item,
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
            decoration: _isItemChecked ? TextDecoration.lineThrough : null,
          ),
        ),
      ),
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
}

class _GetCheckIcon extends StatelessWidget {
  const _GetCheckIcon({
    required this.isItemChecked,
    required this.shoppingItemsStore,
    required this.messageInfoService,
    required this.item,
  });

  final bool? isItemChecked;
  final ShoppingItemsStore? shoppingItemsStore;
  final MessageInfoService? messageInfoService;
  final ShoppingItemModel? item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isItemChecked == false) {
          try {
            shoppingItemsStore?.itemCheck(item!);
          } catch (e) {
            messageInfoService?.showMessage(
              infoMessage: context.translate.errorMessage,
              infoType: InfoTypes.alert,
              context: context,
            );
          }
        } else {
          try {
            shoppingItemsStore?.unCheckItem(item!);
          } catch (e) {
            messageInfoService?.showMessage(
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
          color: isItemChecked! ? AppColors.green : null,
          border: Border.all(
            width: 1,
            color: AppColors.green,
          ),
        ),
        child: isItemChecked!
            ? const Icon(
                Icons.check,
                color: Colors.white,
              )
            : const SizedBox(),
      ),
    );
  }
}

class _GetDeleteIcon extends StatelessWidget {
  const _GetDeleteIcon({
    required this.shoppingItemStore,
    required this.messageInfoService,
    required this.item,
    required this.onTapCallback,
  });

  final ShoppingItemsStore? shoppingItemStore;
  final MessageInfoService? messageInfoService;
  final ShoppingItemModel? item;
  final OnTapCallback? onTapCallback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        try {
          shoppingItemStore!.removeFromList(item!);
          if (onTapCallback != null) {
            onTapCallback!(false);
          }
          messageInfoService?.showMessage(
              context: context,
              infoType: InfoTypes.info,
              infoMessage: context.translate.itemDeleted);
        } catch (e) {
          messageInfoService?.showMessage(
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
}
