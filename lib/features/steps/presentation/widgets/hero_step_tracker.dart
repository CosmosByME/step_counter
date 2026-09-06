import 'dart:math' as math;

import 'package:flutter/material.dart';

class HeroStepTracker extends StatelessWidget {
  const HeroStepTracker({
    super.key,
    required this.steps,
    required this.goal,
  });

  final int steps;
  final int goal;

  @override
  Widget build(BuildContext context) {
    final progress = goal <= 0 ? 0.0 : (steps / goal).clamp(0.0, 1.0);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: progress),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOutCubic,
      builder: (context, animatedProgress, _) {
        return SizedBox(
          height: 280,
          width: 280,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: const Size.square(280),
                painter: _GradientArcPainter(progress: animatedProgress),
              ),
              Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF151721),
                  border: Border.all(color: Colors.white10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.directions_walk, color: Color(0xFF61FF59)),
                    const SizedBox(height: 8),
                    Text(
                      steps.toString(),
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      '$steps / $goal steps',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _GradientArcPainter extends CustomPainter {
  _GradientArcPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2 - 12;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final bgPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..color = Colors.white12
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, -math.pi / 2, math.pi * 2, false, bgPaint);

    final fgPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round
      ..shader = const SweepGradient(
        colors: [Color(0xFF22D3EE), Color(0xFF4ADE80), Color(0xFFF59E0B)],
        startAngle: -math.pi / 2,
        endAngle: math.pi * 1.5,
      ).createShader(rect);

    canvas.drawArc(rect, -math.pi / 2, math.pi * 2 * progress, false, fgPaint);
  }

  @override
  bool shouldRepaint(covariant _GradientArcPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
