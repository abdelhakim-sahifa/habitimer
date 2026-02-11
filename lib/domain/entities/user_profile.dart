import 'package:equatable/equatable.dart';

// User profile entity - represents the current state of the user's habit journey
class UserProfile extends Equatable {
  final String habitName;
  final int currentTimerMinutes;
  final int goodStreak;
  final int badStreak;
  final DateTime lastResetDate;
  final int totalRelapses;
  final int totalSuccesses;

  const UserProfile({
    required this.habitName,
    required this.currentTimerMinutes,
    required this.goodStreak,
    required this.badStreak,
    required this.lastResetDate,
    required this.totalRelapses,
    required this.totalSuccesses,
  });

  // Initial state
  factory UserProfile.initial() {
    return UserProfile(
      habitName: '',
      currentTimerMinutes: 0,
      goodStreak: 0,
      badStreak: 0,
      lastResetDate: DateTime.now(),
      totalRelapses: 0,
      totalSuccesses: 0,
    );
  }

  // Copy with method for immutable updates
  UserProfile copyWith({
    String? habitName,
    int? currentTimerMinutes,
    int? goodStreak,
    int? badStreak,
    DateTime? lastResetDate,
    int? totalRelapses,
    int? totalSuccesses,
  }) {
    return UserProfile(
      habitName: habitName ?? this.habitName,
      currentTimerMinutes: currentTimerMinutes ?? this.currentTimerMinutes,
      goodStreak: goodStreak ?? this.goodStreak,
      badStreak: badStreak ?? this.badStreak,
      lastResetDate: lastResetDate ?? this.lastResetDate,
      totalRelapses: totalRelapses ?? this.totalRelapses,
      totalSuccesses: totalSuccesses ?? this.totalSuccesses,
    );
  }

  @override
  List<Object?> get props => [
        habitName,
        currentTimerMinutes,
        goodStreak,
        badStreak,
        lastResetDate,
        totalRelapses,
        totalSuccesses,
      ];
}
