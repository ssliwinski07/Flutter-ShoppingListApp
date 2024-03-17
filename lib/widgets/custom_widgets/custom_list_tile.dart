import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    this.leading,
    this.title,
    this.padding = const EdgeInsets.only(right: 80),
  });

  final Widget? leading;
  final Widget? title;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding!,
      child: ListTile(
        leading: leading,
        title: title,
      ),
    );
  }
}
