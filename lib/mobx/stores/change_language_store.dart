import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'change_language_store.g.dart';


class ChangeLanguageStore = ChangeLanguageStoreBase with _$ChangeLanguageStore;

abstract class ChangeLanguageStoreBase with Store {
  ChangeLanguageStoreBase();

  @observable
  Locale? locale = const Locale('en');

  @action
  Locale setLocale(){

    if(locale == const Locale('pl')){
      locale = const Locale('en');
    } else if (locale == const Locale ('en')) {
      locale = const Locale('pl');
    }
    return locale!;
  }
  
}