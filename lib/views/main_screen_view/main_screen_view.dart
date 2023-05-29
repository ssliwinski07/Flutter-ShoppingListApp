import 'package:flutter/material.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:shopping_reminder/helpers/methods/locale.dart';
import 'package:shopping_reminder/helpers/constants.dart';
import 'package:shopping_reminder/res/colors/app_colors.dart';
import 'package:shopping_reminder/localizations/app_localization.dart';
import 'package:shopping_reminder/view_models/main_screen_view_model.dart';
import 'package:shopping_reminder/views/shopping_lists_view/shopping_lists_view.dart';
import 'package:shopping_reminder/widgets/buttons/action_buttons/sr_button.dart';
import 'package:shopping_reminder/widgets/loading_screen_animated_widgets/loading_screen_animated_icon.dart';

class MainScreenView extends StatefulWidget {
  const MainScreenView({super.key});

  @override
  State<MainScreenView> createState() => _MainScreenViewState();
}

class _MainScreenViewState extends State<MainScreenView> {
  // ignore: prefer_final_fields
  bool _isLoading = true;
  late MainScreenViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _loadingScreen();
    _viewModel = MainScreenViewModel();
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
              scale: 1.5,
            ),
            const SizedBox(
              height: 200,
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
              buttonTitle: const Text(
                AppLocalization.begin,
                style: TextStyle(color: AppColors.white, fontSize: 20),
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
      Future.delayed(const Duration(seconds: 4))
    ]).then((_) {
      if (mounted) {
        setState(() {
          _isLoading = !_isLoading;
        });
      }
    });
  }
}
