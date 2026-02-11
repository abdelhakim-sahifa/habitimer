import '../../domain/entities/user_profile.dart';

// Data model for UserProfile with JSON serialization
class UserProfileModel extends UserProfile {
  const UserProfileModel({
    required super.habitName,
    required super.currentTimerMinutes,
    required super.goodStreak,
    required super.badStreak,
    required super.lastResetDate,
    required super.totalRelapses,
    required super.totalSuccesses,
  });

  // From JSON
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      habitName: json['habitName'] as String? ?? '',
      currentTimerMinutes: json['currentTimerMinutes'] as int? ?? 0,
      goodStreak: json['goodStreak'] as int? ?? 0,
      badStreak: json['badStreak'] as int? ?? 0,
      lastResetDate: DateTime.parse(
        json['lastResetDate'] as String? ?? DateTime.now().toIso8601String(),
      ),
      totalRelapses: json['totalRelapses'] as int? ?? 0,
      totalSuccesses: json['totalSuccesses'] as int? ?? 0,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'habitName': habitName,
      'currentTimerMinutes': currentTimerMinutes,
      'goodStreak': goodStreak,
      'badStreak': badStreak,
      'lastResetDate': lastResetDate.toIso8601String(),
      'totalRelapses': totalRelapses,
      'totalSuccesses': totalSuccesses,
    };
  }

  // From entity
  factory UserProfileModel.fromEntity(UserProfile profile) {
    return UserProfileModel(
      habitName: profile.habitName,
      currentTimerMinutes: profile.currentTimerMinutes,
      goodStreak: profile.goodStreak,
      badStreak: profile.badStreak,
      lastResetDate: profile.lastResetDate,
      totalRelapses: profile.totalRelapses,
      totalSuccesses: profile.totalSuccesses,
    );
  }

  // To entity
  UserProfile toEntity() {
    return UserProfile(
      habitName: habitName,
      currentTimerMinutes: currentTimerMinutes,
      goodStreak: goodStreak,
      badStreak: badStreak,
      lastResetDate: lastResetDate,
      totalRelapses: totalRelapses,
      totalSuccesses: totalSuccesses,
    );
  }
}
