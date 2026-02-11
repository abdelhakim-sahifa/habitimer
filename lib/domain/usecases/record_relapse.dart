import 'package:dartz/dartz.dart';
import '../repositories/habit_repository.dart';
import '../entities/user_profile.dart';
import '../../core/error/failures.dart';
import '../../core/constants/app_constants.dart';

// Use case for recording a relapse
class RecordRelapse {
  final HabitRepository repository;

  RecordRelapse(this.repository);

  Future<Either<Failure, UserProfile>> call() async {
    // Get current profile
    final profileResult = await repository.getUserProfile();

    return profileResult.fold((failure) => Left(failure), (profile) async {
      // Calculate new timer value based on bad streak
      int increase = AppConstants.relapseIncreaseMinutes;

      // Apply bad streak penalties
      for (var streak in AppConstants.badStreakPenalties.keys) {
        if (profile.badStreak >= streak) {
          increase = AppConstants.badStreakPenalties[streak]!;
        }
      }

      // Calculate new timer value (capped at max)
      int newTimerValue = (profile.currentTimerMinutes + increase).clamp(
        AppConstants.minTimerMinutes,
        AppConstants.maxTimerMinutes,
      );

      // Update profile
      final updatedProfile = profile.copyWith(
        currentTimerMinutes: newTimerValue,
        goodStreak: 0, // Reset good streak
        badStreak: profile.badStreak + 1, // Increment bad streak
        totalRelapses: profile.totalRelapses + 1,
      );

      // Save updated profile
      final saveResult = await repository.saveUserProfile(updatedProfile);

      return saveResult.fold(
        (failure) => Left(failure),
        (_) => Right(updatedProfile),
      );
    });
  }
}
