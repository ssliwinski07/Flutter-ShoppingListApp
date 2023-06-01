import 'package:flutter/material.dart';
import 'package:shopping_reminder/core/services/hive_service/hive_service.dart';
import 'package:shopping_reminder/core/services/services_locator/service_locator.dart';
import 'package:shopping_reminder/views/main_screen_view/main_screen_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ServiceLocator serviceLocator = ServiceLocator();
  await serviceLocator.serviceLocatorInit();

  HiveService hiveRepository = GetIt.instance<HiveService>();
  await hiveRepository.hiveInitialization();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainScreenView(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
