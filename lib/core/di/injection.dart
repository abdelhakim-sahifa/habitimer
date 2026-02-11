import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/datasources/habit_local_data_source.dart';
import '../../data/repositories/habit_repository_impl.dart';
import '../../domain/repositories/habit_repository.dart';
import '../../domain/usecases/get_user_profile.dart';
import '../../domain/usecases/record_relapse.dart';
import '../../domain/usecases/record_success.dart';
import '../../domain/usecases/perform_daily_reset.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Data sources
  sl.registerLazySingleton<HabitLocalDataSource>(
    () => HabitLocalDataSource(sl()),
  );

  // Repository
  sl.registerLazySingleton<HabitRepository>(() => HabitRepositoryImpl(sl()));

  // Use cases
  sl.registerLazySingleton(() => GetUserProfile(sl()));
  sl.registerLazySingleton(() => RecordRelapse(sl()));
  sl.registerLazySingleton(() => RecordSuccess(sl()));
  sl.registerLazySingleton(() => PerformDailyReset(sl()));
}
