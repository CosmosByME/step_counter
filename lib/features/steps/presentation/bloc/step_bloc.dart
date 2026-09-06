import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:step_counter/core/services/pedometer/my_pedometer.dart';

part 'step_event.dart';
part 'step_state.dart';

class StepBloc extends Bloc<StepEvent, StepsState> {
  final pedometer = MyPedometer();


  StepBloc() : super(StepInitial()) {
    on<StepRecord>((event, emit) async {
      await stepRecode(event, emit);
    });
  }

  Future<void> stepRecode(StepRecord event, Emitter<StepsState> emit) async {
    await emit.forEach(pedometer.todaySteps(), onData: (steps) {
      return StepListening(step: steps);
    });
  }
}
