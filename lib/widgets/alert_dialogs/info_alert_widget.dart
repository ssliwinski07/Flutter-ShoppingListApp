import 'package:flutter/material.dart';

class InfoAlertWidget extends StatelessWidget {
  const InfoAlertWidget({
    super.key,
    this.onTap,
    this.leftInfoButtonTitle,
    this.rightInfoButtonTitle,
    this.infoTitle,
  });

  final VoidCallback? onTap;
  final String? infoTitle;
  final String? leftInfoButtonTitle;
  final String? rightInfoButtonTitle;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(children: <Widget>[
        Text(infoTitle!),
        const SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                onTap!();
                Navigator.pop(context);
              },
              child: Text(leftInfoButtonTitle!.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.grey,
                  )),
            ),
            const SizedBox(
              width: 20.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                rightInfoButtonTitle!.toUpperCase(),
                style: const TextStyle(
                  color: Color.fromARGB(255, 226, 81, 70),
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
