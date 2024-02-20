import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shopping_reminder/helpers/helpers.dart';
import 'package:language_code/language_code.dart';

part 'main_screen_store.g.dart';


class MainScreenStore = MainScreenStoreBase with _$MainScreenStore;

abstract class MainScreenStoreBase with Store {
  MainScreenStoreBase();

  @observable
  List<String> iconsDirectory = [
    MAIN_SCREEN_MAIN_ICON_1_DIR,
    MAIN_SCREEN_MAIN_ICON_2_DIR,
    MAIN_SCREEN_MAIN_ICON_3_DIR,
    MAIN_SCREEN_MAIN_ICON_4_DIR,
  ];

  @observable
  Locale? locale = Locale(LanguageCode.rawCode);

  @action
  Locale setLocale(){

    if(locale == const Locale(plLanguage)){
      locale = const Locale(enLanguage);
    } else if (locale == const Locale (enLanguage)) {
      locale = const Locale(plLanguage);
    }
    return locale!;
  }

  @action
  int pickRandomIcon(int range) {
    var randomFigure = Random().nextInt(range);

    return randomFigure;
  }
  
}