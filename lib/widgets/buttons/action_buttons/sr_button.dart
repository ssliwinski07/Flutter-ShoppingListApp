import 'package:flutter/material.dart';

class SRButton extends StatelessWidget {
  const SRButton(
      {required this.color,
      required this.onTap,
      required this.width,
      required this.height,
      required this.borderRadius,
      required this.buttonTitle,
      super.key});

  final Color? color;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Widget? buttonTitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: color,
        ),
        child: Center(
          child: buttonTitle,
        ),
      ),
    );
  }
}
