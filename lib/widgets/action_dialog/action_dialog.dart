import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopping_reminder/helpers/enums.dart';
import 'package:shopping_reminder/mobx/stores/shopping_items_store.dart';

class ActionDialogWidget extends StatefulWidget {
  const ActionDialogWidget.infoAlertWidget({
    super.key,
    this.dialogType,
    this.onTap,
    this.infoTitle,
    this.leftInfoButtonTitle,
    this.rightInfoButtonTitle,
  }) : store = null;

  const ActionDialogWidget.addingItemsDialog({
    super.key,
    this.store,
    this.dialogType,
  })  : onTap = null,
        infoTitle = null,
        leftInfoButtonTitle = null,
        rightInfoButtonTitle = null;

  final ShoppingItemsStore? store;
  final ActionDialogTypes? dialogType;
  final VoidCallback? onTap;
  final String? infoTitle;
  final String? leftInfoButtonTitle;
  final String? rightInfoButtonTitle;

  @override
  State<ActionDialogWidget> createState() => _ActionDialogWidgetState();
}

class _ActionDialogWidgetState extends State<ActionDialogWidget> {
  final TextEditingController _textController = TextEditingController();

  bool _isTextEmpty = true;

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
    return AlertDialog(title: _getWidgetToBuild(widget.dialogType!));
  }

  _getWidgetToBuild(ActionDialogTypes dialogType) {
    switch (dialogType) {
      case ActionDialogTypes.addingItems:
        return _getAddingItemsDialog();
      case ActionDialogTypes.infoAlert:
        return _getInfoAlertWidget();
      default:
        null;
    }
  }

  _getInfoAlertWidget() {
    return Column(
      children: <Widget>[
        Text(widget.infoTitle!),
        const SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                widget.onTap!();
                Navigator.pop(context);
              },
              child: Text(widget.leftInfoButtonTitle!.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.grey,
                  )),
            ),
            const SizedBox(
              width: 20.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                widget.rightInfoButtonTitle!.toUpperCase(),
                style: const TextStyle(
                  color: Color.fromARGB(255, 226, 81, 70),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  _getAddingItemsDialog() {
    return Column(
      children: [
        SizedBox(
          width: 400,
          child: TextFormField(
            cursorColor: Colors.black,
            controller: _textController,
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                AppLocalizations.of(context).cancel.toUpperCase(),
                style: const TextStyle(
                  color: Color.fromARGB(255, 226, 81, 70),
                ),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            GestureDetector(
              onTap: _isTextEmpty == true
                  ? null
                  : () {
                      widget.store?.addToList(_textController.text);
                      _textController.clear();

                      Navigator.pop(context);
                    },
              child: Text(
                AppLocalizations.of(context).add.toUpperCase(),
                style: TextStyle(
                  color: _isTextEmpty
                      ? const Color.fromARGB(255, 214, 214, 214)
                      : Colors.grey,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  void _textListener() {
    setState(() {
      _isTextEmpty = _textController.text.isEmpty;
    });
  }
}
