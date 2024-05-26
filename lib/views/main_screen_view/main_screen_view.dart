import 'package:flutter/material.dart';
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
  late Future<void> _loading;

  @override
  void initState() {
    super.initState();
    _loading = _loadingScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _loading,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 90,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: Text(context.translate.initError),
                      ),
                      if (snapshot.error == null)
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 2.h),
                              child:
                                  Text('${context.translate.moreInfoBelow}:'),
                            ),
                            Text('${snapshot.error}')
                          ],
                        ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: IconButton(
                          onPressed: _reload,
                          icon: const Icon(
                            Icons.refresh,
                            size: 50,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
              return const _GetMainContent();
            } else {
              return const Center(
                  child: LoadingScreenAnimatedIcon(
                iconScale: 10,
                iconDirectory: MAIN_SCREEN_LOADING_ICON_DIR,
              ));
            }
          }),
    );
  }

  void _reload() {
    if (mounted) {
      _loading = _loadingScreen();
      setState(() {});
    }
  }

  Future _loadingScreen() async {
    settingsStore = Provider.of<SettingsStore>(context, listen: false);

    await Future.delayed(const Duration(seconds: 4)); // fake loading
    await Future.wait([
      initializeDateFormatting(LocaleFormats.getLocale()),
      settingsStore.initializeLocale(),
    ]);
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
                // simulate data loading to show shimmer effect only once when opening shopping list view
                if (result == true || _isLoading) {
                  _isLoading = false;
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
