// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shopping_reminder/helpers/methods/locale.dart';
import 'package:shopping_reminder/mobx/stores/shopping_items_store.dart';
import 'package:shopping_reminder/res/colors/app_colors.dart';
import 'package:shopping_reminder/widgets/shopping_list/shopping_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShoppingListsView extends StatefulWidget {
  const ShoppingListsView({super.key});

  @override
  State<ShoppingListsView> createState() => _ShoppingListsViewState();
}

class _ShoppingListsViewState extends State<ShoppingListsView> {
  final ShoppingItemsStore _shoppingItemsStore = ShoppingItemsStore();
  DateTime _today = DateTime.now();

  @override
  void initState() {
    super.initState();
    _shoppingItemsStore.getAllItems();
    _shoppingItemsStore.getCheckedItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            snap: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  child: const Icon(Icons.arrow_back_ios),
                  onTap: () => Navigator.pop(context, true),
                ),
                Text(AppLocalizations.of(context).shoppingLists),
                Observer(
                  builder: (_) {
                    return (_shoppingItemsStore.shoppingItems == null ||
                            _shoppingItemsStore.shoppingItems!.isEmpty)
                        ? const SizedBox()
                        : Text(
                            '${_shoppingItemsStore.countCheckedItems}/${_shoppingItemsStore.countAllItems}');
                  },
                ),
                const SizedBox(width: 40),
                Text(
                  '${LocaleFormats.formatDateTime(_today)}',
                ),
              ],
            ),
            toolbarHeight: 90,
            elevation: 10.0,
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.green,
          ),
        ],
        body: ShoppingList(
          shoppingItemStore: _shoppingItemsStore,
        ),
      ),
    );
  }
}
