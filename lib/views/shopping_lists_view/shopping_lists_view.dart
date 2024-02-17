import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shopping_reminder/helpers/methods/locale.dart';
import 'package:shopping_reminder/mobx/stores/shopping_items_store.dart';
import 'package:shopping_reminder/res/colors/app_colors.dart';
import 'package:shopping_reminder/widgets/shopping_list/shopping_list.dart';
import 'package:shopping_reminder/extensions/translations.dart';
import 'package:provider/provider.dart';

class ShoppingListsView extends StatefulWidget {
  const ShoppingListsView({super.key});

  @override
  State<ShoppingListsView> createState() => _ShoppingListsViewState();
}

class _ShoppingListsViewState extends State<ShoppingListsView> {
  final DateTime _today = DateTime.now();

  bool _isLoading = false;
  late ShoppingItemsStore _store;

  @override
  void initState() {
    super.initState();
    _store = Provider.of<ShoppingItemsStore>(context, listen: false);
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
                      Text(context.translate.shoppingLists),
                      Observer(
                        builder: (_) {
                          return (_store.shoppingItems == null ||
                                  _store.shoppingItems!.isEmpty)
                              ? const SizedBox()
                              : Text(
                                  '${_store.countCheckedItems}/${_store.countAllItems}');
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
    Future.wait([_store.initHive()]).then((_) {
      setState(() {
        _isLoading = !_isLoading;
      });
      _store.getAllItems();
      _store.getCheckedItems();
    });
  }
}
