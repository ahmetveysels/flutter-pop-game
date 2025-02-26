import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart' as lottie;

class AVSLottieAnimation extends StatefulWidget {
  const AVSLottieAnimation({super.key, required this.jsonPath, this.height, this.width, this.repeat = true});
  final String jsonPath;
  final double? height;
  final double? width;
  final bool repeat;
  @override
  State<AVSLottieAnimation> createState() => _ShowLottieAnimationState();
}

class _ShowLottieAnimationState extends State<AVSLottieAnimation> with TickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, animationBehavior: AnimationBehavior.preserve);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return lottie.Lottie.asset(
      widget.jsonPath,
      controller: _controller,
      fit: BoxFit.contain,
      alignment: Alignment.center,
      repeat: true,
      height: widget.height,
      width: widget.width,
      reverse: true,
      onLoaded: (composition) {
        if (widget.repeat) {
          _controller
            ..duration = composition.duration
            ..repeat();
        } else {
          _controller
            ..duration = composition.duration
            ..forward();
        }
      },
    );
  }
}
