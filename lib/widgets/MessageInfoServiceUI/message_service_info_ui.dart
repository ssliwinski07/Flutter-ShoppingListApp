import 'package:flutter/material.dart';
import 'package:shopping_reminder/core/services/message_info_service/message_service_info.dart';
import 'package:shopping_reminder/helpers/enums.dart';
import 'package:shopping_reminder/res/colors/app_colors.dart';

class MessageInfoServiceUI implements MessageInfoService {
  @override
  showMessage({
    BuildContext? context,
    String? infoMessage,
    InfoTypes? infoType,
  }) {
    ScaffoldMessenger.of(context!).showSnackBar(
      SnackBar(
        backgroundColor: _getColor(infoType!),
        content: Row(
          children: [
            const Icon(
              Icons.info_sharp,
              color: AppColors.white,
            ),
            const SizedBox(
              width: 15.0,
            ),
            Text(infoMessage!,
                style: const TextStyle(
                  fontSize: 17.0,
                )),
          ],
        ),
        dismissDirection: DismissDirection.up,
        duration: Duration(seconds: _getInfoDurationTime(infoType)),
        padding: const EdgeInsets.all(20.0),
      ),
    );
  }

  _getInfoDurationTime(InfoTypes infoType) {
    switch (infoType) {
      case InfoTypes.info:
        return 2;
      case InfoTypes.warrning:
        return 3;
      case InfoTypes.alert:
        return 3;
    }
  }

  _getColor(InfoTypes infoType) {
    switch (infoType) {
      case InfoTypes.info:
        return AppColors.black;
      case InfoTypes.warrning:
        return Colors.orange;
      case InfoTypes.alert:
        return Colors.red;
    }
  }
}
