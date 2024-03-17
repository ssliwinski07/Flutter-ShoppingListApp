import 'package:flutter/material.dart';

class SRButton extends StatelessWidget {
  const SRButton(
      {this.color,
      this.onTap,
      this.width,
      this.height,
      this.borderRadius,
      this.buttonTitle,
      super.key});

  final Color? color;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Widget? buttonTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap == null
          ? null
          : () {
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
