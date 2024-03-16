import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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

  final bool _useLottie = true;

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
    return _useLottie ? _getLottieAnimation() : _getCustomAnimation();
  }

  Widget _getLottieAnimation() {
    return Center(
      child: Lottie.asset(
        'lib/res/lottie/lottie_loading3.json',
        repeat: true,
      ),
    );
  }

  Widget _getCustomAnimation() {
    return ScaleTransition(
      scale: Tween(begin: 1.0, end: 1.3).animate(_animationController),
      child: Image.asset(widget.iconDirectory!, scale: widget.iconScale ?? 4.0),
    );
  }
}
