import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'core/core.dart';
import "mobx/stores.dart";
import "views/views.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ServiceLocator serviceLocator = ServiceLocator();
  await serviceLocator.serviceLocatorInit();

  HiveService hiveRepository = GetIt.instance<HiveService>();
  await hiveRepository.hiveInitialization();
  runApp(
    Provider(
      create: (context) => MainScreenStore(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MainScreenStore changeLanguageStore =
        Provider.of<MainScreenStore>(context, listen: false);
    return MultiProvider(
      providers: [
        Provider<ShoppingItemsStore>(create: (context) => ShoppingItemsStore()),
      ],
      child: Observer(
        builder: (context) => MaterialApp(
          home: const MainScreenView(),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: changeLanguageStore.locale,
        ),
      ),
    );
  }
}
