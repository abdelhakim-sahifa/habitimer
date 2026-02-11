import 'package:equatable/equatable.dart';

// Daily log entity - tracks each day's activity
class DailyLog extends Equatable {
  final DateTime date;
  final int timerValueAtStart;
  final bool hadRelapse;
  final int timesUsedTimer;
  final int timesResisted;

  const DailyLog({
    required this.date,
    required this.timerValueAtStart,
    required this.hadRelapse,
    required this.timesUsedTimer,
    required this.timesResisted,
  });

  DailyLog copyWith({
    DateTime? date,
    int? timerValueAtStart,
    bool? hadRelapse,
    int? timesUsedTimer,
    int? timesResisted,
  }) {
    return DailyLog(
      date: date ?? this.date,
      timerValueAtStart: timerValueAtStart ?? this.timerValueAtStart,
      hadRelapse: hadRelapse ?? this.hadRelapse,
      timesUsedTimer: timesUsedTimer ?? this.timesUsedTimer,
      timesResisted: timesResisted ?? this.timesResisted,
    );
  }

  @override
  List<Object?> get props => [
    date,
    timerValueAtStart,
    hadRelapse,
    timesUsedTimer,
    timesResisted,
  ];
}
