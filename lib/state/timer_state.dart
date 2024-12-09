class TimerState {
  final int secondsRemaining;
  final bool isRunning;

  TimerState({
    required this.secondsRemaining,
    required this.isRunning,
  });

  TimerState copyWith({
    int? secondsRemaining,
    bool? isRunning,
  }) {
    return TimerState(
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      isRunning: isRunning ?? this.isRunning,
    );
  }
}
