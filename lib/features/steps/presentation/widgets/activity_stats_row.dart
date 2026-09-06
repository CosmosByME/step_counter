import 'package:flutter/material.dart';
import 'package:step_counter/core/widgets/metric_stat_card.dart';

class ActivityStatsRow extends StatelessWidget {
  const ActivityStatsRow({super.key, required this.steps});

  final int steps;

  @override
  Widget build(BuildContext context) {
    final calories = (steps * 0.04).toStringAsFixed(0);
    final distance = (steps * 0.0008).toStringAsFixed(2);
    final activeMinutes = (steps / 100).toStringAsFixed(0);

    return Row(
      children: [
        Expanded(
          child: MetricStatCard(
            icon: Icons.local_fire_department_rounded,
            label: 'Calories',
            value: '$calories kcal',
            color: const Color(0xFFFF8A65),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: MetricStatCard(
            icon: Icons.route_rounded,
            label: 'Distance',
            value: '$distance km',
            color: const Color(0xFF4DD0E1),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: MetricStatCard(
            icon: Icons.timer_outlined,
            label: 'Active',
            value: '$activeMinutes min',
            color: const Color(0xFF81C784),
          ),
        ),
      ],
    );
  }
}
