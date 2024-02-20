import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'core/core.dart';
import "mobx/stores.dart";
import "views/views.dart";

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();

  ServiceLocator serviceLocator = ServiceLocator();

  Future<void> initialization() async {
    await serviceLocator.serviceLocatorInit();
    await serviceLocator.uiServiceLocatorInit();

    HiveService hiveRepository = GetIt.instance<HiveService>();
    await hiveRepository.hiveInitialization();
  }

  await initialization();

  SettingsService settingsService = GetIt.instance<SettingsService>();

  runApp(
    MultiProvider(
      providers: [
        Provider<ShoppingItemsStore>(create: (context) => ShoppingItemsStore()),
        Provider<MainScreenStore>(create: (context) => MainScreenStore()),
        Provider<SettingsStore>(create: (context) =>  SettingsStore(settingsService: settingsService))
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsStore settingsStore = Provider.of<SettingsStore>(context, listen: false);

    return Sizer(
      builder: (context, orientation, deviceType) => Observer(
        builder: (context) => MaterialApp(
          home: const MainScreenView(),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: settingsStore.locale,
        ),
      ),
    );
  }

}
