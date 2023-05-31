import 'package:hive/hive.dart';

part 'shopping_item_model.g.dart';

@HiveType(typeId: 0)
class ShoppingItemModel extends HiveObject {
  ShoppingItemModel({
    required this.id,
    required this.isChecked,
    required this.name,
  });

  @HiveField(0)
  late int id;

  @HiveField(1)
  late bool isChecked;

  @HiveField(2)
  late String name;
}
