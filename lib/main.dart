import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shopping_reminder/helpers/methods/locale.dart';
import 'package:shopping_reminder/views/main_screen_view/main_screen_view.dart';

void main() async {
  await initializeDateFormatting(LocaleFormats.getLocale());
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
    );
  }
}
