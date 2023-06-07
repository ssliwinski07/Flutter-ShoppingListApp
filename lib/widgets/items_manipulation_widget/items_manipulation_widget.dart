import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopping_reminder/core/services/message_info_service/message_service_info.dart';
import 'package:shopping_reminder/helpers/constants.dart';
import 'package:shopping_reminder/helpers/enums.dart';
import 'package:shopping_reminder/models/shopping_item_model.dart';
import 'package:shopping_reminder/res/colors/app_colors.dart';
import 'package:get_it/get_it.dart';

class ItemsManipulationWidget extends StatefulWidget {
  const ItemsManipulationWidget({
    super.key,
    this.shouldHideDialog,
    this.onTap,
    this.itemManipulationType,
    this.shoppingItem,
  });

  final bool? shouldHideDialog;
  final Function(String text)? onTap;
  final ItemManipulationType? itemManipulationType;
  final ShoppingItemModel? shoppingItem;

  @override
  State<ItemsManipulationWidget> createState() =>
      _ItemsManipulationWidgetState();
}

class _ItemsManipulationWidgetState extends State<ItemsManipulationWidget> {
  final TextEditingController _textController = TextEditingController();

  bool _isTextEmpty = true;
  bool _isItemChanged = false;
  bool _isTheSameText = false;

  final MessageInfoService _messageService =
      GetIt.instance<MessageInfoService>();

  @override
  void initState() {
    super.initState();
    _textController.addListener(_textListener);
    if (widget.shoppingItem != null &&
        widget.itemManipulationType == ItemManipulationType.update) {
      _textController.text = widget.shoppingItem!.name;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      title: SizedBox(
        width: 400,
        child: TextFormField(
          cursorColor: Colors.black,
          controller: _textController,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context).enterItem,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
      ),
      actions: !_isItemChanged
          ? _getActions(widget.itemManipulationType!)
          : _getItemInfo(widget.itemManipulationType!),
    );
  }

  _getActions(ItemManipulationType itemManipulationType) {
    switch (itemManipulationType) {
      case ItemManipulationType.add:
        return _getActionsForAddItem();
      case ItemManipulationType.update:
        return _getActionsForUpdateItem();
    }
  }

  _getItemInfo(ItemManipulationType itemManipulationType) {
    switch (itemManipulationType) {
      case ItemManipulationType.add:
        return _getItemAddedInfo();
      case ItemManipulationType.update:
        return _getItemUpdatedInfo();
    }
  }

  List<Widget> _getActionsForAddItem() {
    var items = [
      GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 10.0,
          ),
          child: Text(
            AppLocalizations.of(context).cancel.toUpperCase(),
            style: const TextStyle(
              color: Color.fromARGB(255, 226, 81, 70),
              fontSize: 16.0,
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: _isTextEmpty == true ? null : _onTap,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
            bottom: 10.0,
            right: 10.0,
          ),
          child: Text(
            AppLocalizations.of(context).add.toUpperCase(),
            style: TextStyle(
              fontSize: 16.0,
              color: _isTextEmpty
                  ? const Color.fromARGB(255, 214, 214, 214)
                  : Colors.grey,
            ),
          ),
        ),
      )
    ];
    return items;
  }

  List<Widget> _getItemAddedInfo() {
    var items = [
      Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
          bottom: 10.0,
          right: 10.0,
        ),
        child: Text(
          AppLocalizations.of(context).itemAdded.toUpperCase(),
          style: const TextStyle(
            fontSize: 16.0,
            color: AppColors.green,
          ),
        ),
      )
    ];
    return items;
  }

  List<Widget> _getActionsForUpdateItem() {
    var items = [
      GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 10.0,
          ),
          child: Text(
            AppLocalizations.of(context).cancel.toUpperCase(),
            style: const TextStyle(
              color: Color.fromARGB(255, 226, 81, 70),
              fontSize: 16.0,
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: _isTextEmpty == true || _isTheSameText == true ? null : _onTap,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
            bottom: 10.0,
            right: 10.0,
          ),
          child: Text(
            AppLocalizations.of(context).update.toUpperCase(),
            style: TextStyle(
              fontSize: 16.0,
              color: _isTextEmpty || _isTheSameText
                  ? const Color.fromARGB(255, 214, 214, 214)
                  : Colors.grey,
            ),
          ),
        ),
      )
    ];
    return items;
  }

  _onTap() {
    try {
      if (_textController.text.contains('dupa')) {
        throw ();
      }
      widget.onTap!(_textController.text.trim());
      _textController.clear();
      _isItemChanged = true;
      _itemChanged();
      if (widget.shouldHideDialog == true) {
        _delayeDialogHide();
      }
    } catch (e) {
      _messageService.showMessage(
        context: context,
        infoMessage: AppLocalizations.of(context).errorMessage,
        infoType: InfoTypes.alert,
      );
      Navigator.pop(context);
    }
  }

  List<Widget> _getItemUpdatedInfo() {
    var items = [
      Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
          bottom: 10.0,
          right: 10.0,
        ),
        child: Text(
          AppLocalizations.of(context).itemUpdated.toUpperCase(),
          style: const TextStyle(
            fontSize: 16.0,
            color: AppColors.green,
          ),
        ),
      )
    ];
    return items;
  }

  Future<void> _delayeDialogHide() async {
    Future.delayed(const Duration(milliseconds: ADDING_ITEM_DURATION))
        .then((_) => Navigator.pop(context));
  }

  Future<void> _itemChanged() async {
    Future.delayed(const Duration(milliseconds: ADDING_ITEM_DURATION))
        .then((_) {
      setState(() {
        _isItemChanged = false;
      });
    });
  }

  void _textListener() {
    setState(() {
      _isTextEmpty = _textController.text.isEmpty;
      if (widget.itemManipulationType == ItemManipulationType.update &&
          widget.shoppingItem != null) {
        _isTheSameText =
            _textController.text.trim() == widget.shoppingItem!.name;
      }
    });
  }
}
