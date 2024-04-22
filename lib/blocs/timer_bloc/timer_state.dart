part of 'timer_bloc.dart';

sealed class TimerState extends Equatable {
  const TimerState(this.secondsLeft);
  final int secondsLeft;

  @override
  List<Object> get props => [secondsLeft];
}

final class TimerInitial extends TimerState {
  const TimerInitial(super.secondsLeft);
}

final class TimerRunPause extends TimerState {
  const TimerRunPause(super.secondsLeft);
}

final class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(super.secondsLeft);
}

final class TimerRunComplete extends TimerState {
  const TimerRunComplete() : super(0);
}
