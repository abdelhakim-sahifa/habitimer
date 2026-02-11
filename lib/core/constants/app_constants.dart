// Core constants for the Habitimer app
class AppConstants {
  // Timer constraints
  static const int minTimerMinutes = 0;
  static const int maxTimerMinutes = 90;
  
  // Timer adjustments
  static const int dailyDecreaseMinutes = 1;
  static const int relapseIncreaseMinutes = 2;
  
  // Streak multipliers
  static const Map<int, double> goodStreakMultipliers = {
    7: 1.5,   // 1 week
    14: 2.0,  // 2 weeks
    30: 3.0,  // 1 month
  };
  
  static const Map<int, int> badStreakPenalties = {
    2: 3,  // +3 minutes instead of +2
    4: 4,  // +4 minutes
    7: 5,  // +5 minutes
  };
  
  // Local storage keys
  static const String keyTimerValue = 'timer_value';
  static const String keyGoodStreak = 'good_streak';
  static const String keyBadStreak = 'bad_streak';
  static const String keyLastResetDate = 'last_reset_date';
  static const String keyTotalRelapses = 'total_relapses';
  static const String keyTotalSuccesses = 'total_successes';
  static const String keyDailyLogs = 'daily_logs';
  static const String keyTimerSessions = 'timer_sessions';
  static const String keyHabitName = 'habit_name';
}
