import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:shopping_reminder/models/shopping_item_model.dart';

class HiveService {
  Future<void> hiveInitialization() async {
    final appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    Hive.registerAdapter(ShoppingItemModelAdapter());

    await Hive.openBox<ShoppingItemModel>('shoppingItems');
  }
}
