import 'package:flutter/material.dart';

import 'package:shopping_reminder/helpers/helpers.dart';

abstract interface class MessageInfoService {
  void showMessage({
    BuildContext? context,
    String? infoMessage,
    InfoTypes? infoType,
  });
}
