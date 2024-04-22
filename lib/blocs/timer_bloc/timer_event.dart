part of 'timer_bloc.dart';

sealed class TimerEvent {
  const TimerEvent();
}

final class StopButton extends TimerEvent {
  const StopButton();
}

final class PlayPauseButton extends TimerEvent {
  const PlayPauseButton();
}

class _TimerTicked extends TimerEvent {
  const _TimerTicked({required this.duration});
  final int duration;
}
