import 'package:flutter/material.dart';

import 'package:intl/date_symbol_data_local.dart';
import "package:provider/provider.dart";
import "package:shopping_reminder/extensions/extensions.dart";
import "package:shopping_reminder/helpers/helpers.dart";
import "package:shopping_reminder/mobx/stores/change_language_store.dart";
import "package:shopping_reminder/res/res.dart";
import "package:shopping_reminder/view_models/view_models.dart";
import "package:shopping_reminder/views/views.dart";
import "package:shopping_reminder/widgets/widgets.dart";

class MainScreenView extends StatefulWidget {
  const MainScreenView({super.key});

  @override
  State<MainScreenView> createState() => _MainScreenViewState();
}

class _MainScreenViewState extends State<MainScreenView> {
  // ignore: prefer_final_fields
  bool _isLoading = true;
  late MainScreenViewModel _viewModel;
  late ChangeLanguageStore _store;

  @override
  void initState() {
    super.initState();
    _loadingScreen();
    _viewModel = MainScreenViewModel();
    _store = Provider.of<ChangeLanguageStore>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: LoadingScreenAnimatedIcon(
              iconScale: 10,
              iconDirectory: MAIN_SCREEN_LOADING_ICON_DIR,
            ))
          : _getMainContent(),
    );
  }

  Widget _getMainContent() {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(top: 170.0),
        child: Column(
          children: <Widget>[
            Image.asset(
              _viewModel.iconsDirectory[
                  _viewModel.pickRandomIcon(_viewModel.iconsDirectory.length)],
              scale: 2,
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              textAlign: TextAlign.center,
              context.translate.welcomeText,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SRButton(
              color: AppColors.green,
              borderRadius: BorderRadius.circular(40),
              height: 50,
              width: 250,
              onTap: () async {
                bool result = await Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const ShoppingListsView(),
                  ),
                );
                if (result == true) {
                  setState(() {});
                }
              },
              buttonTitle: Text(
                context.translate.begin,
                style: const TextStyle(color: AppColors.white, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SRButton(
              color: AppColors.green,
              borderRadius: BorderRadius.circular(40),
              height: 50,
              width: 250,
              onTap: () {
                _store.setLocale();
              },
              buttonTitle: Text(
                context.translate.changeLanguage,
                style: const TextStyle(color: AppColors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _loadingScreen() async {
    Future.wait([
      initializeDateFormatting(LocaleFormats.getLocale()),
      Future.delayed(const Duration(seconds: 5))
    ]).then((_) {
      if (mounted) {
        setState(() {
          _isLoading = !_isLoading;
        });
      }
    });
  }
}
