import 'package:dartz/dartz.dart';
import '../../domain/repositories/habit_repository.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/entities/daily_log.dart';
import '../../domain/entities/timer_session.dart';
import '../../core/error/failures.dart';
import '../datasources/habit_local_data_source.dart';
import '../models/user_profile_model.dart';
import '../models/daily_log_model.dart';
import '../models/timer_session_model.dart';

// Implementation of HabitRepository
class HabitRepositoryImpl implements HabitRepository {
  final HabitLocalDataSource localDataSource;

  HabitRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, UserProfile>> getUserProfile() async {
    try {
      final profile = await localDataSource.getUserProfile();
      return Right(profile.toEntity());
    } catch (e) {
      return Left(
        StorageFailure('Failed to get user profile: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> saveUserProfile(UserProfile profile) async {
    try {
      final model = UserProfileModel.fromEntity(profile);
      await localDataSource.saveUserProfile(model);
      return const Right(null);
    } catch (e) {
      return Left(
        StorageFailure('Failed to save user profile: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> updateTimerValue(int minutes) async {
    try {
      final profile = await localDataSource.getUserProfile();
      final updated = UserProfileModel.fromEntity(
        profile.copyWith(currentTimerMinutes: minutes),
      );
      await localDataSource.saveUserProfile(updated);
      return const Right(null);
    } catch (e) {
      return Left(
        StorageFailure('Failed to update timer value: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> updateStreaks({
    int? goodStreak,
    int? badStreak,
  }) async {
    try {
      final profile = await localDataSource.getUserProfile();
      final updated = UserProfileModel.fromEntity(
        profile.copyWith(goodStreak: goodStreak, badStreak: badStreak),
      );
      await localDataSource.saveUserProfile(updated);
      return const Right(null);
    } catch (e) {
      return Left(StorageFailure('Failed to update streaks: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> performDailyReset() async {
    try {
      // This is handled by the use case
      return const Right(null);
    } catch (e) {
      return Left(
        StorageFailure('Failed to perform daily reset: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> recordRelapse() async {
    try {
      // This is handled by the use case
      return const Right(null);
    } catch (e) {
      return Left(StorageFailure('Failed to record relapse: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> recordSuccess() async {
    try {
      // This is handled by the use case
      return const Right(null);
    } catch (e) {
      return Left(StorageFailure('Failed to record success: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<DailyLog>>> getDailyLogs({int? limit}) async {
    try {
      final logs = await localDataSource.getDailyLogs(limit: limit);
      return Right(logs.map((log) => log.toEntity()).toList());
    } catch (e) {
      return Left(StorageFailure('Failed to get daily logs: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> saveDailyLog(DailyLog log) async {
    try {
      final model = DailyLogModel.fromEntity(log);
      await localDataSource.saveDailyLog(model);
      return const Right(null);
    } catch (e) {
      return Left(StorageFailure('Failed to save daily log: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<TimerSession>>> getTimerSessions({
    int? limit,
  }) async {
    try {
      final sessions = await localDataSource.getTimerSessions(limit: limit);
      return Right(sessions.map((session) => session.toEntity()).toList());
    } catch (e) {
      return Left(
        StorageFailure('Failed to get timer sessions: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> saveTimerSession(TimerSession session) async {
    try {
      final model = TimerSessionModel.fromEntity(session);
      await localDataSource.saveTimerSession(model);
      return const Right(null);
    } catch (e) {
      return Left(
        StorageFailure('Failed to save timer session: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> clearAllData() async {
    try {
      await localDataSource.clearAllData();
      return const Right(null);
    } catch (e) {
      return Left(StorageFailure('Failed to clear all data: ${e.toString()}'));
    }
  }
}
