import 'dart:math';
import 'package:mobx/mobx.dart';
import 'package:shopping_reminder/helpers/helpers.dart';

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

  @action
  int randomFigure(int range) {
    var randomFigure = Random().nextInt(range);

    return randomFigure;
  }
  
}