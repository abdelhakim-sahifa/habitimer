import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/entities/user_profile.dart';
import '../models/user_profile_model.dart';
import '../models/daily_log_model.dart';
import '../models/timer_session_model.dart';

// Local data source using SharedPreferences
class HabitLocalDataSource {
  final SharedPreferences sharedPreferences;

  HabitLocalDataSource(this.sharedPreferences);

  // User Profile
  Future<UserProfileModel> getUserProfile() async {
    final jsonString = sharedPreferences.getString('user_profile');
    if (jsonString != null) {
      return UserProfileModel.fromJson(json.decode(jsonString));
    }
    // Return initial profile if none exists
    return UserProfileModel.fromEntity(UserProfile.initial());
  }

  Future<void> saveUserProfile(UserProfileModel profile) async {
    await sharedPreferences.setString(
      'user_profile',
      json.encode(profile.toJson()),
    );
  }

  // Daily Logs
  Future<List<DailyLogModel>> getDailyLogs({int? limit}) async {
    final jsonString = sharedPreferences.getString('daily_logs');
    if (jsonString == null) return [];

    final List<dynamic> jsonList = json.decode(jsonString);
    final logs = jsonList.map((json) => DailyLogModel.fromJson(json)).toList();

    // Sort by date descending
    logs.sort((a, b) => b.date.compareTo(a.date));

    if (limit != null && logs.length > limit) {
      return logs.sublist(0, limit);
    }
    return logs;
  }

  Future<void> saveDailyLog(DailyLogModel log) async {
    final logs = await getDailyLogs();
    logs.insert(0, log);

    // Keep only last 90 days
    if (logs.length > 90) {
      logs.removeRange(90, logs.length);
    }

    await sharedPreferences.setString(
      'daily_logs',
      json.encode(logs.map((log) => log.toJson()).toList()),
    );
  }

  // Timer Sessions
  Future<List<TimerSessionModel>> getTimerSessions({int? limit}) async {
    final jsonString = sharedPreferences.getString('timer_sessions');
    if (jsonString == null) return [];

    final List<dynamic> jsonList = json.decode(jsonString);
    final sessions = jsonList
        .map((json) => TimerSessionModel.fromJson(json))
        .toList();

    // Sort by start time descending
    sessions.sort((a, b) => b.startTime.compareTo(a.startTime));

    if (limit != null && sessions.length > limit) {
      return sessions.sublist(0, limit);
    }
    return sessions;
  }

  Future<void> saveTimerSession(TimerSessionModel session) async {
    final sessions = await getTimerSessions();
    sessions.insert(0, session);

    // Keep only last 100 sessions
    if (sessions.length > 100) {
      sessions.removeRange(100, sessions.length);
    }

    await sharedPreferences.setString(
      'timer_sessions',
      json.encode(sessions.map((session) => session.toJson()).toList()),
    );
  }

  // Clear all data
  Future<void> clearAllData() async {
    await sharedPreferences.clear();
  }
}
