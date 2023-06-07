import 'package:flutter/material.dart';
import 'package:shopping_reminder/core/services/message_info_service/message_service_info.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopping_reminder/helpers/enums.dart';

class InfoAlertWidget extends StatelessWidget {
  InfoAlertWidget({
    super.key,
    this.onTap,
    this.infoTitle,
    this.leftInfoButtonTitle,
    this.rightInfoButtonTitle,
  });

  final VoidCallback? onTap;
  final String? infoTitle;
  final String? leftInfoButtonTitle;
  final String? rightInfoButtonTitle;

  final MessageInfoService _messageService =
      GetIt.instance<MessageInfoService>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(infoTitle!),
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.normal,
        color: Colors.black,
        fontSize: 17.0,
      ),
      actions: [
        GestureDetector(
          onTap: () {
            try {
              onTap!();
              _messageService.showMessage(
                context: context,
                infoMessage: AppLocalizations.of(context).itemsDeleted,
                infoType: InfoTypes.info,
              );
              Navigator.pop(context);
            } catch (e) {
              _messageService.showMessage(
                context: context,
                infoMessage: AppLocalizations.of(context).errorMessage,
                infoType: InfoTypes.alert,
              );
              Navigator.pop(context);
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 10.0,
            ),
            child: Text(leftInfoButtonTitle!.toUpperCase(),
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                )),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              bottom: 10.0,
              right: 10.0,
            ),
            child: Text(
              rightInfoButtonTitle!.toUpperCase(),
              style: const TextStyle(
                fontSize: 16.0,
                color: Color.fromARGB(255, 226, 81, 70),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
