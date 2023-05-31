import 'package:flutter/material.dart';
import 'package:shopping_reminder/mobx/stores/shopping_items_store.dart';
import 'package:shopping_reminder/res/colors/app_colors.dart';
import 'package:shopping_reminder/widgets/adding_items_widget/adding_items_widget.dart';
import 'package:shopping_reminder/widgets/buttons/action_buttons/sr_button.dart';
import 'package:shopping_reminder/widgets/no_content_info_widget/no_content_widget.dart';
import 'package:shopping_reminder/widgets/shopping_list/shopping_list_item.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({super.key});

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final ShoppingItemsStore _shoppingItemsStore = ShoppingItemsStore();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return _shoppingItemsStore.shoppingItems == null ||
                _shoppingItemsStore.shoppingItems!.isEmpty
            ? NoContentInfoWidget(
                isAddingButtonVisible: true,
                onTap: _showDialog,
              )
            : SizedBox(
                height: 400,
                child: Stack(
                  children: [
                    Observer(
                      builder: (_) => ListView.builder(
                        padding: const EdgeInsets.only(bottom: 10.0, top: 5.0),
                        physics: const BouncingScrollPhysics(),
                        itemCount: _shoppingItemsStore.shoppingItems!.length,
                        itemBuilder: (BuildContext context, int index) {
                          var item = _shoppingItemsStore.shoppingItems?[index];
                          return ShoppingListItem(
                            shoppingItem: item,
                            store: _shoppingItemsStore,
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 40.0,
                      right: 40.0,
                      child: SRButton(
                        width: 60,
                        height: 60,
                        borderRadius: BorderRadius.circular(30),
                        onTap: _showDialog,
                        color: AppColors.green,
                        buttonTitle: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }

  _showDialog() {
    showDialog(
        context: context,
        builder: (context) => AddingItemsWidget(
              store: _shoppingItemsStore,
            ));
  }
}

// _showDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Column(
//           children: [
//             TextFormField(
//               controller: _textController,
//             ),
//             const SizedBox(
//               height: 20.0,
//             ),
//             Row(
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     String newItem = _textController.text;

//                     shoppingItems?.add(ShoppingItemModel(
//                       id: UniqueKey().hashCode,
//                       name: newItem,
//                     ));
//                     Navigator.pop(context);
//                     setState(() {});
//                   },
//                   child: const Text('Dodaj'),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// No overscroll animation
// return Scrollbar(
//       child: SizedBox(
//         width: 500,
//         child: NotificationListener<OverscrollIndicatorNotification>(
//           onNotification: (OverscrollIndicatorNotification? overscroll) {
//             overscroll?.disallowIndicator();
//             return true;
//           },
//           child: ListView.builder(
//             //physics: const BouncingScrollPhysics(),
//             itemCount: shoppingItems?.length,
//             itemBuilder: (BuildContext context, int index) {
//               var item = shoppingItems?[index];

//               return ShoppingListItem(
//                 shoppingItem: item,
//               );
//             },
//           ),
//         ),
//       ),
//     );
