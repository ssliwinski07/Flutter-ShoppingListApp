import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:shopping_reminder/helpers/helpers.dart';
import 'package:shopping_reminder/mobx/stores.dart';
import 'package:shopping_reminder/res/res.dart';
import 'package:shopping_reminder/widgets/widgets.dart';
import 'package:shopping_reminder/extensions/extensions.dart';


class ShoppingListsView extends StatefulWidget {
  const ShoppingListsView({super.key});

  @override
  State<ShoppingListsView> createState() => _ShoppingListsViewState();
}

class _ShoppingListsViewState extends State<ShoppingListsView> {
  final DateTime _today = DateTime.now();

  bool _isLoading = false;
  late ShoppingItemsStore _shoppingItemStore;
  late MainScreenStore _mainScreenStore;

  @override
  void initState() {
    super.initState();
    _shoppingItemStore = Provider.of<ShoppingItemsStore>(context, listen: false);
    _mainScreenStore = Provider.of<MainScreenStore>(context, listen: false);
    _loading(simulateLoading: false);
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
          )
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
                      Text(context.translate.shoppingLists),
                      Observer(
                        builder: (_) {
                          return (_shoppingItemStore.shoppingItems == null ||
                                  _shoppingItemStore.shoppingItems!.isEmpty)
                              ? const SizedBox()
                              : Text(
                                  '${_shoppingItemStore.countCheckedItems}/${_shoppingItemStore.countAllItems}');
                        },
                      ),
                      const SizedBox(width: 40),
                      Text(
                        '${LocaleFormats.formatDateTime(_today, languageCode: _mainScreenStore.locale?.languageCode)}',
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

  Future<void> _loading({bool? simulateLoading}) {
    if (simulateLoading == true) {
      return Future.delayed(
        const Duration(seconds: 2),
        () => Future.wait([_shoppingItemStore.initHive()]).then(
          (_) {
            setState(() {
              _isLoading = !_isLoading;
            });
            _shoppingItemStore.getAllItems();
            _shoppingItemStore.getCheckedItems();
          },
        ),
      );
    }
    return Future.wait([_shoppingItemStore.initHive()]).then(
      (_) {
        setState(() {
          _isLoading = !_isLoading;
        });
        _shoppingItemStore.getAllItems();
        _shoppingItemStore.getCheckedItems();
      },
    );
  }
}
