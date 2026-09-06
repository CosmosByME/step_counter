import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_counter/core/widgets/animated_number.dart';

import '../bloc/step_bloc.dart';

class StepPage extends StatelessWidget {
  const StepPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool animationIsShown = false;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'Step Counter',
          style: Theme.of(context).textTheme.headlineSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have taken:'),
            BlocBuilder<StepBloc, StepsState>(
              builder: (context, state) {
                return AnimatedNumber(milliseconds: 800,
                  number: state is StepListening ? state.step : 0, onEnd: () {
                    animationIsShown = true;
                  },
                );
              },
            ),
            const Text('steps'),
          ],
        ),
      ),
    );
  }
}
