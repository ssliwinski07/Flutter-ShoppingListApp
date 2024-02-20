import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shopping_reminder/core/core.dart';

import 'package:shopping_reminder/helpers/helpers.dart';

part 'settings_store.g.dart';

class SettingsStore = SettingsStoreBase with _$SettingsStore;

abstract class SettingsStoreBase with Store {
  SettingsStoreBase({
    required this.settingsService,
  }) {
    initializeLocale();
  }

  final SettingsService settingsService;

  @observable
  Locale? locale;

  @action
  Future<Locale> setLocale() async {
    
    if (locale == const Locale(plLanguage)) {
      settingsService.setString(key: 'language', value: enLanguage);
      String langugageCode = await settingsService.getString(key: 'language') ?? enLanguage;
      locale =  Locale(langugageCode);
    } else if (locale == const Locale(enLanguage)) {
      settingsService.setString(key: 'language', value: plLanguage);
      String languageCode =  await settingsService.getString(key: 'language') ?? plLanguage;
      locale = Locale(languageCode);
    
    }
    return locale!;
  }

  @action
  initializeLocale() async {
    String languageCode = await settingsService.getString(key: 'language') ?? enLanguage;
    locale = Locale(languageCode);
    return locale;
  }

}
