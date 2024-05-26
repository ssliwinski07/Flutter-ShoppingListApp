import 'package:flutter/material.dart';
import "package:flutter_mobx/flutter_mobx.dart";
import 'package:intl/date_symbol_data_local.dart';
import "package:provider/provider.dart";
import "package:sizer/sizer.dart";

import "package:shopping_reminder/extensions/extensions.dart";
import "package:shopping_reminder/helpers/helpers.dart";
import "package:shopping_reminder/mobx/stores.dart";
import "package:shopping_reminder/res/res.dart";
import "package:shopping_reminder/views/views.dart";
import "package:shopping_reminder/widgets/widgets.dart";

class MainScreenView extends StatefulWidget {
  const MainScreenView({super.key});

  @override
  State<MainScreenView> createState() => _MainScreenViewState();
}

class _MainScreenViewState extends State<MainScreenView> {
  late SettingsStore settingsStore;

  @override
  void initState() {
    super.initState();
    _loadingScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Scaffold(
        body: settingsStore.isLoading
            ? const Center(
                child: LoadingScreenAnimatedIcon(
                iconScale: 10,
                iconDirectory: MAIN_SCREEN_LOADING_ICON_DIR,
              ))
            : const _GetMainContent(),
      ),
    );
  }

  Future _loadingScreen() async {
    settingsStore = Provider.of<SettingsStore>(context, listen: false);

    await Future.delayed(const Duration(seconds: 4)); // fake loading
    await Future.wait([
      initializeDateFormatting(LocaleFormats.getLocale()),
      settingsStore.initializeLocale(),
    ]);
    settingsStore.isLoadingToggle();
  }
}

class _GetMainContent extends StatefulWidget {
  const _GetMainContent();

  @override
  State<_GetMainContent> createState() => _GetMainContentState();
}

class _GetMainContentState extends State<_GetMainContent> {
  late SettingsStore _settingsStore;
  late MainScreenStore _mainScreenStore;

  // ignore: prefer_final_fields
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _settingsStore = Provider.of<SettingsStore>(context, listen: false);
    _mainScreenStore = Provider.of<MainScreenStore>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    int range = _mainScreenStore.iconsDirectory.length;

    return Center(
      child: Container(
        height: 100.h,
        padding: EdgeInsets.only(top: 8.h),
        child: Column(
          children: <Widget>[
            Image.asset(
              _mainScreenStore
                  .iconsDirectory[_mainScreenStore.randomFigure(range)],
              scale: 2,
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              textAlign: TextAlign.center,
              context.translate.welcomeText,
              style: TextStyle(
                fontSize: 40.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 4.h,
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
                    pageBuilder: (_, __, ___) => ShoppingListsView(
                      isLoading: _isLoading,
                    ),
                  ),
                );
                if (result == true) {
                  // simulate data loading to show shimmer effect only once when opening shopping list view
                  if (mounted) {
                    _isLoading = false;
                    setState(() {});
                  }
                }
              },
              buttonTitle: Text(
                context.translate.begin,
                style: const TextStyle(color: AppColors.white, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            SRButton(
              color: AppColors.green,
              borderRadius: BorderRadius.circular(40),
              height: 50,
              width: 250,
              onTap: () {
                _settingsStore.setLocale();
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
}
