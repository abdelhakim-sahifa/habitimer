import 'package:dartz/dartz.dart';
import '../repositories/habit_repository.dart';
import '../entities/user_profile.dart';
import '../../core/error/failures.dart';
import '../../core/constants/app_constants.dart';

// Use case for performing daily timer reset (decrease)
class PerformDailyReset {
  final HabitRepository repository;

  PerformDailyReset(this.repository);

  Future<Either<Failure, UserProfile>> call() async {
    // Get current profile
    final profileResult = await repository.getUserProfile();
    
    return profileResult.fold(
      (failure) => Left(failure),
      (profile) async {
        // Calculate decrease amount based on good streak
        double decrease = AppConstants.dailyDecreaseMinutes.toDouble();
        
        // Apply good streak multipliers
        for (var streak in AppConstants.goodStreakMultipliers.keys.toList()..sort((a, b) => b.compareTo(a))) {
          if (profile.goodStreak >= streak) {
            decrease *= AppConstants.goodStreakMultipliers[streak]!;
            break;
          }
        }
        
        // Calculate new timer value (capped at min)
        int newTimerValue = (profile.currentTimerMinutes - decrease.toInt())
            .clamp(AppConstants.minTimerMinutes, AppConstants.maxTimerMinutes);
        
        // Update profile
        final updatedProfile = profile.copyWith(
          currentTimerMinutes: newTimerValue,
          lastResetDate: DateTime.now(),
        );
        
        // Save updated profile
        final saveResult = await repository.saveUserProfile(updatedProfile);
        
        return saveResult.fold(
          (failure) => Left(failure),
          (_) => Right(updatedProfile),
        );
      },
    );
  }
}
