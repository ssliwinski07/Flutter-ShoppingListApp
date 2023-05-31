import 'package:flutter/material.dart';
import 'package:shopping_reminder/mobx/stores/shopping_items_store.dart';
import 'package:shopping_reminder/models/shopping_item_model.dart';
import 'package:shopping_reminder/res/colors/app_colors.dart';

class ShoppingListItem extends StatefulWidget {
  const ShoppingListItem({
    super.key,
    this.shoppingItem,
    this.store,
    this.index,
  });

  final ShoppingItemModel? shoppingItem;
  final ShoppingItemsStore? store;
  final int? index;

  @override
  State<ShoppingListItem> createState() => _ShoppingListItemState();
}

class _ShoppingListItemState extends State<ShoppingListItem> {
  bool _isChecked = false;
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.red,
          child: ListTile(
            trailing: IconButton(
              onPressed: () async {
                setState(() {
                  Future.delayed(const Duration(milliseconds: 400)).then((_) {
                    _isTapped = !_isTapped;
                    widget.store?.removeFromList(widget.shoppingItem!);
                  });
                });
              },
              icon: const Icon(Icons.delete_forever),
              color: Colors.white,
            ),
          ),
        ),
        AnimatedContainer(
          color: Colors.white,
          width: _isTapped ? 330 : MediaQuery.of(context).size.width,
          duration: const Duration(milliseconds: 400),
          child: ListTile(
              leading: GestureDetector(
                onTap: () {
                  _itemCheck();
                },
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.shoppingItem!.isChecked!
                        ? AppColors.green
                        : null,
                    border: Border.all(
                      width: 1,
                      color: AppColors.green,
                    ),
                  ),
                  child: widget.shoppingItem!.isChecked!
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                        )
                      : const SizedBox(),
                ),
              ),
              title: GestureDetector(
                onTap: () {
                  setState(() {});
                  _isTapped = !_isTapped;
                },
                child: Text(
                  widget.shoppingItem!.name!,
                  style: TextStyle(
                    color: widget.shoppingItem!.isChecked!
                        ? Colors.grey
                        : Colors.black,
                    decoration: widget.shoppingItem!.isChecked!
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
              )),
        ),
      ],
    );
  }

  void _itemCheck() {
    setState(() {
      _isChecked = !_isChecked;
      widget.shoppingItem!.isChecked = !widget.shoppingItem!.isChecked!;
    });
    widget.store?.removeFromList(widget.shoppingItem!);
    if (widget.shoppingItem!.isChecked == true) {
      widget.store?.addToListAfterItemCheck(widget.shoppingItem!);
    } else {
      widget.store?.addToListAfterItemUncheck(widget.shoppingItem!);
    }
  }
}
