import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:shopping_reminder/helpers/helpers.dart';
import 'package:shopping_reminder/mobx/stores.dart';
import 'package:shopping_reminder/res/res.dart';
import 'package:shopping_reminder/widgets/widgets.dart';
import 'package:shopping_reminder/extensions/extensions.dart';

class ShoppingListsView extends StatefulWidget {
  const ShoppingListsView({super.key, this.isLoading});

  final bool? isLoading;

  @override
  State<ShoppingListsView> createState() => _ShoppingListsViewState();
}

class _ShoppingListsViewState extends State<ShoppingListsView>
    with SingleTickerProviderStateMixin {
  final DateTime _today = DateTime.now();

  bool _isLoading = false;
  late ShoppingItemsStore _shoppingItemStore;
  late SettingsStore _settingsStore;

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _shoppingItemStore =
        Provider.of<ShoppingItemsStore>(context, listen: false);
    _settingsStore = Provider.of<SettingsStore>(context, listen: false);
    _animationController =
        AnimationController(duration: const Duration(seconds: 3), vsync: this)
          ..repeat();
    _loading(simulateLoading: widget.isLoading);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
                Text(context.translate.shoppingLists),
                Observer(
                  builder: (_) {
                    return (_shoppingItemStore.shoppingItems == null ||
                                _shoppingItemStore.shoppingItems!.isEmpty) ||
                            !_isLoading
                        ? const SizedBox()
                        : Text(
                            '${_shoppingItemStore.countCheckedItems}/${_shoppingItemStore.countAllItems}');
                  },
                ),
                const SizedBox(width: 40),
                Text(
                  '${LocaleFormats.formatDateTime(
                    _today,
                    languageCode: _settingsStore.locale?.languageCode,
                  )}',
                ),
              ],
            ),
            toolbarHeight: 90,
            elevation: 10.0,
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.green,
          ),
        ],
        body: !_isLoading ? const _CustomLoading() : const ShoppingList(),
      ),
    );
  }

  Future<void> _loading({bool? simulateLoading}) {
    if (simulateLoading == true) {
      return Future.delayed(
        const Duration(seconds: 6),
        () => Future.wait([_shoppingItemStore.initHive()]).then(
          (_) {
            if (mounted) {
              setState(() {
                _isLoading = !_isLoading;
              });
            }
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

class _CustomLoading extends StatelessWidget {
  const _CustomLoading();

  @override
  Widget build(BuildContext context) => ListView.builder(
        padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
        itemCount: 10,
        itemBuilder: (context, index) => ListTile(
          leading: const CustomLoading.circle(height: 25, width: 25),
          title: CustomLoading.rectangular(
            height: 25,
            borderShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      );
}
