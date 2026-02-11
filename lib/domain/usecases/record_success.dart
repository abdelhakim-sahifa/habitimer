import 'package:dartz/dartz.dart';
import '../repositories/habit_repository.dart';
import '../entities/user_profile.dart';
import '../../core/error/failures.dart';
import '../../core/constants/app_constants.dart';

// Use case for recording a success (resisted urge)
class RecordSuccess {
  final HabitRepository repository;

  RecordSuccess(this.repository);

  Future<Either<Failure, UserProfile>> call() async {
    // Get current profile
    final profileResult = await repository.getUserProfile();

    return profileResult.fold((failure) => Left(failure), (profile) async {
      // Calculate timer decrease with streak multiplier (reward for resisting)
      double decreaseAmount = AppConstants.dailyDecreaseMinutes.toDouble();

      // Apply good streak multipliers for enhanced rewards
      double multiplier = 1.0;
      for (var entry in AppConstants.goodStreakMultipliers.entries) {
        if (profile.goodStreak >= entry.key) {
          multiplier = entry.value;
        }
      }

      decreaseAmount *= multiplier;

      int newTimerValue = (profile.currentTimerMinutes - decreaseAmount.round())
          .clamp(AppConstants.minTimerMinutes, AppConstants.maxTimerMinutes);

      // Update profile
      final updatedProfile = profile.copyWith(
        currentTimerMinutes: newTimerValue, // Decrease timer as reward
        badStreak: 0, // Reset bad streak
        goodStreak: profile.goodStreak + 1, // Increment good streak
        totalSuccesses: profile.totalSuccesses + 1,
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
