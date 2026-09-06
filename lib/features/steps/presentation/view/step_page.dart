import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_counter/core/widgets/dashboard_header.dart';
import 'package:step_counter/features/steps/presentation/widgets/activity_stats_row.dart';
import 'package:step_counter/features/steps/presentation/widgets/hero_step_tracker.dart';
import 'package:step_counter/features/steps/presentation/widgets/weekly_activity_chart.dart';

import '../bloc/step_bloc.dart';

class StepPage extends StatelessWidget {
  const StepPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surfaceContainerHighest,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: BlocBuilder<StepBloc, StepsState>(
            builder: (context, state) {
              final steps = state is StepListening ? state.step : 0;
              const goal = 8000;
              final isActive = state is StepListening;

              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const DashboardHeader(),
                    const SizedBox(height: 20),
                    HeroStepTracker(steps: steps, goal: goal),
                    const SizedBox(height: 20),
                    ActivityStatsRow(steps: steps),
                    const SizedBox(height: 18),
                    WeeklyActivityChart(todaySteps: steps, goal: goal),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
