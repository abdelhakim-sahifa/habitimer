import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/usecases/get_user_profile.dart';
import '../../domain/usecases/record_relapse.dart';
import '../../domain/usecases/record_success.dart';
import '../../domain/usecases/perform_daily_reset.dart';
import '../../core/di/injection.dart';

// State for the habit tracker
class HabitState {
  final UserProfile profile;
  final bool isLoading;
  final String? errorMessage;

  HabitState({
    required this.profile,
    this.isLoading = false,
    this.errorMessage,
  });

  HabitState copyWith({
    UserProfile? profile,
    bool? isLoading,
    String? errorMessage,
  }) {
    return HabitState(
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

// Notifier for habit state
class HabitNotifier extends StateNotifier<HabitState> {
  final GetUserProfile _getUserProfile;
  final RecordRelapse _recordRelapse;
  final RecordSuccess _recordSuccess;
  final PerformDailyReset _performDailyReset;

  HabitNotifier(
    this._getUserProfile,
    this._recordRelapse,
    this._recordSuccess,
    this._performDailyReset,
  ) : super(HabitState(profile: UserProfile.initial())) {
    loadProfile();
  }

  // Load user profile
  Future<void> loadProfile() async {
    state = state.copyWith(isLoading: true);

    final result = await _getUserProfile();

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      ),
      (profile) => state = state.copyWith(
        profile: profile,
        isLoading: false,
        errorMessage: null,
      ),
    );
  }

  // Record a relapse
  Future<void> recordRelapse() async {
    state = state.copyWith(isLoading: true);

    final result = await _recordRelapse();

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      ),
      (profile) => state = state.copyWith(
        profile: profile,
        isLoading: false,
        errorMessage: null,
      ),
    );
  }

  // Record a success
  Future<void> recordSuccess() async {
    state = state.copyWith(isLoading: true);

    final result = await _recordSuccess();

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      ),
      (profile) => state = state.copyWith(
        profile: profile,
        isLoading: false,
        errorMessage: null,
      ),
    );
  }

  // Perform daily reset
  Future<void> performDailyReset() async {
    state = state.copyWith(isLoading: true);

    final result = await _performDailyReset();

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      ),
      (profile) => state = state.copyWith(
        profile: profile,
        isLoading: false,
        errorMessage: null,
      ),
    );
  }
}

// Provider for habit state
final habitProvider = StateNotifierProvider<HabitNotifier, HabitState>((ref) {
  return HabitNotifier(
    sl<GetUserProfile>(),
    sl<RecordRelapse>(),
    sl<RecordSuccess>(),
    sl<PerformDailyReset>(),
  );
});
