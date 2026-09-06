part of 'step_bloc.dart';

sealed class StepsState extends Equatable {
  const StepsState();
}

final class StepInitial extends StepsState {
  @override
  List<Object> get props => [];
}

final class StepListening extends StepsState {
  final int step;

  const StepListening({required this.step});
  @override
  List<Object> get props => [step];
}

final class StepClosed extends StepsState {
  @override
  List<Object> get props => [];
}
