import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockin/state/timer_state.dart';
import 'dart:async';

class TimerNotifier extends StateNotifier<TimerState> {
  Timer? _timer;

  TimerNotifier() : super(TimerState(secondsRemaining: 180, isRunning: false));

  void startTimer() {
    if (state.isRunning) return;

    state = state.copyWith(secondsRemaining: 180, isRunning: true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.secondsRemaining > 0) {
        state = state.copyWith(secondsRemaining: state.secondsRemaining - 1);
      } else {
        timer.cancel();
        state = state.copyWith(isRunning: false);
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    state = state.copyWith(isRunning: false);
  }

  void resetTimer() {
    _timer?.cancel();
    state = TimerState(secondsRemaining: 180, isRunning: false);
  }
}

final timerProvider = StateNotifierProvider<TimerNotifier, TimerState>(
  (ref) => TimerNotifier(),
);
