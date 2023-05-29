import 'package:flutter/material.dart';
import 'package:shopping_reminder/helpers/constants.dart';
import 'package:shopping_reminder/localizations/app_localization.dart';
import 'package:shopping_reminder/res/colors/app_colors.dart';
import 'package:shopping_reminder/widgets/buttons/action_buttons/sr_button.dart';

class NoContentInfoWidget extends StatelessWidget {
  NoContentInfoWidget({
    super.key,
    this.onTap,
    this.isAddingButtonVisible = false,
  });

  final VoidCallback? onTap;
  final bool? isAddingButtonVisible;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: <Widget>[
            Image.asset(
              MAIN_SCREEN_LOADING_ICON_DIR,
              scale: 5,
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              AppLocalization.noContent,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            isAddingButtonVisible!
                ? SRButton(
                    color: AppColors.green,
                    onTap: () {
                      onTap!();
                    },
                    width: 250,
                    height: 50,
                    borderRadius: BorderRadius.circular(40),
                    buttonTitle: const Text(
                      AppLocalization.startAdding,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20,
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ],
    ));
  }
}
