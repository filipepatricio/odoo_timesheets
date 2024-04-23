import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:odoo_apexive/blocs/bloc_exports.dart';
import 'package:odoo_apexive/data/models/ticker.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc({required int duration})
      : _duration = duration,
        super(TimerInitial(duration)) {
    on<PlayPauseButton>(_onPlayPauseButton);
    on<StopButton>(_onStopButton);
    on<_TimerTicked>(_onTicked);
  }

  final Ticker _ticker = const Ticker();
  final int _duration;

  StreamSubscription<int>? _tickerSubscription;

  void _onPlayPauseButton(PlayPauseButton event, Emitter<TimerState> emit) {
    switch (state) {
      case TimerInitial():
        _onStarted(emit);
        break;
      case TimerRunInProgress():
        _onPaused(emit);
        break;
      case TimerRunPause():
        _onResumed(emit);
        break;
      case TimerRunComplete():
        _onReset(emit);
        _onStarted(emit);
        break;
    }
  }

  void _onStopButton(StopButton event, Emitter<TimerState> emit) {
    _onStopped(emit);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(Emitter<TimerState> emit) {
    emit(TimerRunInProgress(state.secondsLeft));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: state.secondsLeft)
        .listen((duration) => add(_TimerTicked(duration: duration)));
  }

  void _onPaused(Emitter<TimerState> emit) {
    if (state is TimerRunInProgress) {
      _tickerSubscription?.pause();
      emit(TimerRunPause(state.secondsLeft));
    }
  }

  void _onResumed(Emitter<TimerState> emit) {
    if (state is TimerRunPause) {
      _tickerSubscription?.resume();
      emit(TimerRunInProgress(state.secondsLeft));
    }
  }

  void _onStopped(Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit(const TimerRunComplete());
  }

  void _onReset(Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit(TimerInitial(_duration));
  }

  void _onTicked(_TimerTicked event, Emitter<TimerState> emit) {
    emit(
      event.duration > 0
          ? TimerRunInProgress(event.duration)
          : const TimerRunComplete(),
    );
  }
}
