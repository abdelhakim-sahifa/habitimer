import 'package:equatable/equatable.dart';

// Enum for session outcome
enum SessionOutcome {
  resisted,
  relapsed,
  cancelled,
}

// Timer session entity - records each timer usage
class TimerSession extends Equatable {
  final DateTime startTime;
  final int durationSeconds;
  final bool completed;
  final SessionOutcome outcome;
  final String? notes;

  const TimerSession({
    required this.startTime,
    required this.durationSeconds,
    required this.completed,
    required this.outcome,
    this.notes,
  });

  TimerSession copyWith({
    DateTime? startTime,
    int? durationSeconds,
    bool? completed,
    SessionOutcome? outcome,
    String? notes,
  }) {
    return TimerSession(
      startTime: startTime ?? this.startTime,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      completed: completed ?? this.completed,
      outcome: outcome ?? this.outcome,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [
        startTime,
        durationSeconds,
        completed,
        outcome,
        notes,
      ];
}
