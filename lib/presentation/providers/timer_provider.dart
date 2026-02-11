import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Timer state
class TimerState {
  final int remainingSeconds;
  final bool isRunning;
  final bool isPaused;

  TimerState({
    required this.remainingSeconds,
    this.isRunning = false,
    this.isPaused = false,
  });

  TimerState copyWith({
    int? remainingSeconds,
    bool? isRunning,
    bool? isPaused,
  }) {
    return TimerState(
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isRunning: isRunning ?? this.isRunning,
      isPaused: isPaused ?? this.isPaused,
    );
  }
}

// Timer notifier
class TimerNotifier extends StateNotifier<TimerState> {
  Timer? _timer;

  TimerNotifier() : super(TimerState(remainingSeconds: 0));

  // Start timer with duration in minutes
  void startTimer(int durationMinutes) {
    // Cancel existing timer if any
    _timer?.cancel();

    final totalSeconds = durationMinutes * 60;
    state = TimerState(remainingSeconds: totalSeconds, isRunning: true);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingSeconds > 0) {
        state = state.copyWith(remainingSeconds: state.remainingSeconds - 1);
      } else {
        stopTimer();
      }
    });
  }

  // Pause timer
  void pauseTimer() {
    _timer?.cancel();
    state = state.copyWith(isPaused: true, isRunning: false);
  }

  // Resume timer
  void resumeTimer() {
    if (state.remainingSeconds > 0) {
      state = state.copyWith(isPaused: false, isRunning: true);
      
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (state.remainingSeconds > 0) {
          state = state.copyWith(remainingSeconds: state.remainingSeconds - 1);
        } else {
          stopTimer();
        }
      });
    }
  }

  // Stop timer
  void stopTimer() {
    _timer?.cancel();
    state = TimerState(remainingSeconds: 0, isRunning: false, isPaused: false);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

// Provider for timer state
final timerProvider = StateNotifierProvider<TimerNotifier, TimerState>((ref) {
  return TimerNotifier();
});
