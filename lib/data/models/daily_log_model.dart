import '../../domain/entities/daily_log.dart';

// Data model for DailyLog with JSON serialization
class DailyLogModel extends DailyLog {
  const DailyLogModel({
    required super.date,
    required super.timerValueAtStart,
    required super.hadRelapse,
    required super.timesUsedTimer,
    required super.timesResisted,
  });

  // From JSON
  factory DailyLogModel.fromJson(Map<String, dynamic> json) {
    return DailyLogModel(
      date: DateTime.parse(json['date'] as String),
      timerValueAtStart: json['timerValueAtStart'] as int,
      hadRelapse: json['hadRelapse'] as bool,
      timesUsedTimer: json['timesUsedTimer'] as int,
      timesResisted: json['timesResisted'] as int,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'timerValueAtStart': timerValueAtStart,
      'hadRelapse': hadRelapse,
      'timesUsedTimer': timesUsedTimer,
      'timesResisted': timesResisted,
    };
  }

  // From entity
  factory DailyLogModel.fromEntity(DailyLog log) {
    return DailyLogModel(
      date: log.date,
      timerValueAtStart: log.timerValueAtStart,
      hadRelapse: log.hadRelapse,
      timesUsedTimer: log.timesUsedTimer,
      timesResisted: log.timesResisted,
    );
  }

  // To entity
  DailyLog toEntity() {
    return DailyLog(
      date: date,
      timerValueAtStart: timerValueAtStart,
      hadRelapse: hadRelapse,
      timesUsedTimer: timesUsedTimer,
      timesResisted: timesResisted,
    );
  }
}
