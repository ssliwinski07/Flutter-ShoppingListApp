import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopping_reminder/mobx/stores/shopping_items_store.dart';

class AddingItemsWidget extends StatefulWidget {
  const AddingItemsWidget({
    super.key,
    this.store,
  });

  final ShoppingItemsStore? store;

  @override
  State<AddingItemsWidget> createState() => _AddingItemsWidgetState();
}

class _AddingItemsWidgetState extends State<AddingItemsWidget> {
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
      actions: <Widget>[
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
                  widget.store?.addToList(_textController.text);
                  _textController.clear();

                  Navigator.pop(context);
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
        ),
      ],
    );
  }

  void _textListener() {
    setState(() {
      _isTextEmpty = _textController.text.isEmpty;
    });
  }
}
