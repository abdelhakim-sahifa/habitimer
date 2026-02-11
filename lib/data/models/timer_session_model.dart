import '../../domain/entities/timer_session.dart';

// Data model for TimerSession with JSON serialization
class TimerSessionModel extends TimerSession {
  const TimerSessionModel({
    required super.startTime,
    required super.durationSeconds,
    required super.completed,
    required super.outcome,
    super.notes,
  });

  // From JSON
  factory TimerSessionModel.fromJson(Map<String, dynamic> json) {
    return TimerSessionModel(
      startTime: DateTime.parse(json['startTime'] as String),
      durationSeconds: json['durationSeconds'] as int,
      completed: json['completed'] as bool,
      outcome: SessionOutcome.values.firstWhere(
        (e) => e.toString() == 'SessionOutcome.${json['outcome']}',
        orElse: () => SessionOutcome.cancelled,
      ),
      notes: json['notes'] as String?,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime.toIso8601String(),
      'durationSeconds': durationSeconds,
      'completed': completed,
      'outcome': outcome.toString().split('.').last,
      'notes': notes,
    };
  }

  // From entity
  factory TimerSessionModel.fromEntity(TimerSession session) {
    return TimerSessionModel(
      startTime: session.startTime,
      durationSeconds: session.durationSeconds,
      completed: session.completed,
      outcome: session.outcome,
      notes: session.notes,
    );
  }

  // To entity
  TimerSession toEntity() {
    return TimerSession(
      startTime: startTime,
      durationSeconds: durationSeconds,
      completed: completed,
      outcome: outcome,
      notes: notes,
    );
  }
}
