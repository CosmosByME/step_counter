part of 'step_bloc.dart';

sealed class StepEvent extends Equatable {
  const StepEvent();
}

class StepInitialize extends Equatable {
  @override
  List<Object> get props => [];
}


class StepRecord extends StepEvent {
  final int step;

  const StepRecord({required this.step});

  @override
  List<Object> get props => [step];
}

class StepStop extends StepEvent {
  final int step;
  final DateTime timestamp;

  const StepStop({required this.step, required this.timestamp});

  @override
  List<Object> get props => [step, timestamp];
}