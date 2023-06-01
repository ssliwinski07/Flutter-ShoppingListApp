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
      title: Column(
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
                onTap: _isTextEmpty
                    ? null
                    : () {
                        widget.store?.addToList(_textController.text);
                        _textController.clear();

                        //Navigator.pop(context);
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
      ),
    );
  }

  void _textListener() {
    setState(() {
      _isTextEmpty = _textController.text.isEmpty;
    });
  }
}
