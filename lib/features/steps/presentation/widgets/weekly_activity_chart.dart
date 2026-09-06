import 'dart:math' as math;

import 'package:flutter/material.dart';

class WeeklyActivityChart extends StatelessWidget {
  const WeeklyActivityChart({
    super.key,
    required this.todaySteps,
    required this.goal,
  });

  final int todaySteps;
  final int goal;

  @override
  Widget build(BuildContext context) {
    final samples = _sampleData(todaySteps);
    const labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1C26),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Weekly Activity', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 14),
          SizedBox(
            height: 120,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(samples.length, (i) {
                final value = samples[i];
                final ratio = goal <= 0 ? 0.0 : (value / goal).clamp(0.08, 1.0);
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeOutCubic,
                          height: 90 * ratio,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF22D3EE), Color(0xFF4ADE80)],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(labels[i], style: const TextStyle(color: Colors.white60)),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  List<int> _sampleData(int base) {
    final normalized = math.max(1200, base);
    return List.generate(7, (i) {
      if (i == 6) return base;
      final modifier = 0.55 + (i * 0.08);
      return (normalized * modifier).toInt();
    });
  }
}
