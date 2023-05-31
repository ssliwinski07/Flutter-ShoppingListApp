// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:shopping_reminder/helpers/methods/locale.dart';
import 'package:shopping_reminder/res/colors/app_colors.dart';
import 'package:shopping_reminder/widgets/shopping_list/shopping_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShoppingListsView extends StatefulWidget {
  const ShoppingListsView({super.key});

  @override
  State<ShoppingListsView> createState() => _ShoppingListsViewState();
}

class _ShoppingListsViewState extends State<ShoppingListsView> {
  DateTime _today = DateTime.now();

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
}
