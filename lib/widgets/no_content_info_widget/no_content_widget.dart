import 'package:flutter/material.dart';

import 'package:shopping_reminder/extensions/extensions.dart';
import 'package:shopping_reminder/helpers/helpers.dart';
import 'package:shopping_reminder/res/res.dart';
import 'package:shopping_reminder/widgets/widgets.dart';

class NoContentInfoWidget extends StatelessWidget {
  const NoContentInfoWidget({
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
              scale: 7,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              context.translate.noContent,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            isAddingButtonVisible!
                ? SRButton(
                    color: AppColors.green,
                    onTap: () {
                      onTap!();
                    },
                    width: 250,
                    borderRadius: BorderRadius.circular(40),
                    buttonTitle: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        context.translate.startAdding,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 20,
                        ),
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
