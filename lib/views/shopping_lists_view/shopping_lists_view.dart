// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:shopping_reminder/helpers/methods/locale.dart';
import 'package:shopping_reminder/localizations/app_localization.dart';
import 'package:shopping_reminder/res/colors/app_colors.dart';

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
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              child: const Icon(Icons.arrow_back_ios),
              onTap: () => Navigator.pop(context, true),
            ),
            const Text(AppLocalization.shoppingLists),
            const SizedBox(width: 40),
            Column(
              children: [
                const Text(
                  AppLocalization.todayIs,
                ),
                Text(
                  '${LocaleFormats.formatDateTime(_today)}',
                ),
              ],
            )
          ],
        ),
        toolbarHeight: 90,
        elevation: 10.0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.green,
      ),
    );
  }
}
