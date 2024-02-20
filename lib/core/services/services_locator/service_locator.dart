import 'package:get_it/get_it.dart';

import 'package:shopping_reminder/core/services/services.dart';
import 'package:shopping_reminder/widgets/widgets.dart';

class ServiceLocator {
  GetIt serviceLocator = GetIt.instance;


  //Core Service locators
  Future<void> serviceLocatorInit() async {
    serviceLocator.registerSingleton<HiveService>(HiveService());
  }

  //Core UI Service locators
  Future<void> uiServiceLocatorInit() async {
    serviceLocator
        .registerSingleton<MessageInfoService>(MessageInfoServiceUI());
  }
}
