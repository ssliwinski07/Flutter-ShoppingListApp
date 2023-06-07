import 'package:get_it/get_it.dart';
import 'package:shopping_reminder/core/services/hive_service/hive_service.dart';
import 'package:shopping_reminder/core/services/message_info_service/message_service_info.dart';

class ServiceLocator {
  GetIt serviceLocator = GetIt.instance;

  Future<void> serviceLocatorInit() async {
    serviceLocator.registerSingleton<HiveService>(HiveService());
    serviceLocator.registerSingleton<MessageInfoService>(MessageInfoService());
  }
}
