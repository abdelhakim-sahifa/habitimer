import 'package:dartz/dartz.dart';
import '../entities/user_profile.dart';
import '../entities/daily_log.dart';
import '../entities/timer_session.dart';
import '../../core/error/failures.dart';

// Repository interface for habit data
// This defines what operations we can do with our data
// The actual implementation will be in the data layer
abstract class HabitRepository {
  // User Profile operations
  Future<Either<Failure, UserProfile>> getUserProfile();
  Future<Either<Failure, void>> saveUserProfile(UserProfile profile);
  Future<Either<Failure, void>> updateTimerValue(int minutes);
  Future<Either<Failure, void>> updateStreaks({
    int? goodStreak,
    int? badStreak,
  });

  // Daily operations
  Future<Either<Failure, void>> performDailyReset();
  Future<Either<Failure, void>> recordRelapse();
  Future<Either<Failure, void>> recordSuccess();

  // Daily logs
  Future<Either<Failure, List<DailyLog>>> getDailyLogs({int? limit});
  Future<Either<Failure, void>> saveDailyLog(DailyLog log);

  // Timer sessions
  Future<Either<Failure, List<TimerSession>>> getTimerSessions({int? limit});
  Future<Either<Failure, void>> saveTimerSession(TimerSession session);

  // Utility
  Future<Either<Failure, void>> clearAllData();
}
