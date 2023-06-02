import 'package:flutter/material.dart';

class InfoAlertWidget extends StatelessWidget {
  const InfoAlertWidget({
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
            onTap!();
            Navigator.pop(context);
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
