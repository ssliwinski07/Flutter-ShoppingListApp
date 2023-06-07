import 'package:flutter/material.dart';

class SnackBarInfo {
  static void show({BuildContext? context, String? infoMessage}) {
    ScaffoldMessenger.of(context!).showSnackBar(
      SnackBar(
        content: Text(infoMessage!,
            style: const TextStyle(
              fontSize: 17.0,
            )),
        dismissDirection: DismissDirection.up,
        duration: const Duration(seconds: 2),
        padding: const EdgeInsets.all(20.0),
      ),
    );
  }
}
