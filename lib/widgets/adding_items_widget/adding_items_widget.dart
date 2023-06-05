import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopping_reminder/helpers/constants.dart';
import 'package:shopping_reminder/mobx/stores/shopping_items_store.dart';
import 'package:provider/provider.dart';
import 'package:shopping_reminder/res/colors/app_colors.dart';

class AddingItemsWidget extends StatefulWidget {
  const AddingItemsWidget({
    super.key,
    this.shouldHideDialog,
  });

  final bool? shouldHideDialog;

  @override
  State<AddingItemsWidget> createState() => _AddingItemsWidgetState();
}

class _AddingItemsWidgetState extends State<AddingItemsWidget> {
  final TextEditingController _textController = TextEditingController();

  bool _isTextEmpty = true;
  bool _isItemAdded = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_textListener);
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
      actions: !_isItemAdded
          ? _getActions()
          : [
              _getItemAddedInfo(),
            ],
    );
  }

  List<Widget> _getActions() {
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
        onTap: _isTextEmpty == true
            ? null
            : () {
                Provider.of<ShoppingItemsStore>(context, listen: false)
                    .addToList(_textController.text);
                _textController.clear();
                _isItemAdded = true;
                _itemAdded();
                if (widget.shouldHideDialog == true) {
                  _delayedHideDialog();
                }
              },
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

  Widget _getItemAddedInfo() {
    return Padding(
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
    );
  }

  Future<void> _delayedHideDialog() async {
    Future.delayed(const Duration(milliseconds: ADDING_ITEM_DURATION))
        .then((value) => Navigator.pop(context));
  }

  Future<void> _itemAdded() async {
    Future.delayed(const Duration(milliseconds: ADDING_ITEM_DURATION))
        .then((_) {
      setState(() {
        _isItemAdded = false;
      });
    });
  }

  void _textListener() {
    setState(() {
      _isTextEmpty = _textController.text.isEmpty;
    });
  }
}
