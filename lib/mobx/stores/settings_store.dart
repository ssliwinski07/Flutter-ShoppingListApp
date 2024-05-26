import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shopping_reminder/core/core.dart';

import 'package:shopping_reminder/helpers/helpers.dart';

part 'settings_store.g.dart';

class SettingsStore = SettingsStoreBase with _$SettingsStore;

abstract class SettingsStoreBase with Store {
  SettingsStoreBase({
    required this.settingsService,
  });

  final SettingsService settingsService;

  @observable
  Locale? locale;

  @action
  void setLocale() {
    if (locale == const Locale(plLanguage)) {
      settingsService.setString(key: languageKey, value: enLanguage);
      locale = const Locale(enLanguage);
    } else if (locale == const Locale(enLanguage)) {
      settingsService.setString(key: languageKey, value: plLanguage);
      locale = const Locale(plLanguage);
    }
  }

  @action
  Future<void> initializeLocale() async {
    String languageCode = await settingsService.getString(key: languageKey);
    locale = Locale(languageCode);
  }
}
