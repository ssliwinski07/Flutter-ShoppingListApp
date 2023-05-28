import 'package:flutter/material.dart';

class LoadingScreenAnimatedIcon extends StatefulWidget {
  const LoadingScreenAnimatedIcon(
      {super.key, required this.iconDirectory, this.iconScale});

  final String? iconDirectory;
  final double? iconScale;

  @override
  State<LoadingScreenAnimatedIcon> createState() =>
      _LoadingScreenAnimatedIconState();
}

class _LoadingScreenAnimatedIconState extends State<LoadingScreenAnimatedIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween(begin: 1.0, end: 1.3).animate(_animationController),
      child: Image.asset(widget.iconDirectory!, scale: widget.iconScale ?? 4.0),
    );
  }
}
