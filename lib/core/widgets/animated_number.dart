import 'package:flutter/material.dart';

class AnimatedNumber extends StatelessWidget {
  final VoidCallback? onEnd;
  final int number;
  final int? milliseconds;
  const AnimatedNumber({this.milliseconds, this.onEnd, super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: number.toDouble()),
      duration: Duration(milliseconds: milliseconds ?? 500),
      builder: (context, value, child) {
        return Text(
          '${(value).toInt()}',
          style: Theme.of(context).textTheme.headlineMedium,
        );
      },
      onEnd: onEnd,
    );
  }
}
