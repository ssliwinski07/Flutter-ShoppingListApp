import 'dart:math';

import 'package:shopping_reminder/helpers/constants.dart';

class MainScreenViewModel {
  List<String> iconsDirectory = [
    MAIN_SCREEN_MAIN_ICON_1_DIR,
    MAIN_SCREEN_MAIN_ICON_2_DIR,
    MAIN_SCREEN_MAIN_ICON_3_DIR,
    MAIN_SCREEN_MAIN_ICON_4_DIR,
  ];

  int pickRandomIcon(int range) {
    var randomFigure = Random().nextInt(range);

    return randomFigure;
  }
}
