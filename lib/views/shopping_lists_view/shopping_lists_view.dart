// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shopping_reminder/helpers/methods/locale.dart';
import 'package:shopping_reminder/mobx/stores/shopping_items_store.dart';
import 'package:shopping_reminder/res/colors/app_colors.dart';
import 'package:shopping_reminder/widgets/shopping_list/shopping_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ShoppingListsView extends StatefulWidget {
  const ShoppingListsView({super.key});

  @override
  State<ShoppingListsView> createState() => _ShoppingListsViewState();
}

class _ShoppingListsViewState extends State<ShoppingListsView> {
  DateTime _today = DateTime.now();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loading();
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoading
        ? const Scaffold(
            body: Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ))
        : Scaffold(
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
                          return (Provider.of<ShoppingItemsStore>(context,
                                              listen: false)
                                          .shoppingItems ==
                                      null ||
                                  Provider.of<ShoppingItemsStore>(context,
                                          listen: false)
                                      .shoppingItems!
                                      .isEmpty)
                              ? const SizedBox()
                              : Text(
                                  '${Provider.of<ShoppingItemsStore>(context, listen: false).countCheckedItems}/${Provider.of<ShoppingItemsStore>(context, listen: false).countAllItems}');
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
              body: const ShoppingList(),
            ),
          );
  }

  Future<void> _loading() async {
    Future.wait([
      Provider.of<ShoppingItemsStore>(context, listen: false).initHive()
    ]).then((_) {
      setState(() {
        _isLoading = !_isLoading;
      });
      Provider.of<ShoppingItemsStore>(context, listen: false).getAllItems();
      Provider.of<ShoppingItemsStore>(context, listen: false).getCheckedItems();
    });
  }
}
