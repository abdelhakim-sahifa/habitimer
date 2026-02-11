import 'package:dartz/dartz.dart';
import '../repositories/habit_repository.dart';
import '../entities/user_profile.dart';
import '../../core/error/failures.dart';

// Use case for getting user profile
class GetUserProfile {
  final HabitRepository repository;

  GetUserProfile(this.repository);

  Future<Either<Failure, UserProfile>> call() async {
    return await repository.getUserProfile();
  }
}
