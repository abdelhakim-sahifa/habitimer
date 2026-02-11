import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/habit_provider.dart';
import '../providers/timer_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/timer_display.dart';
import '../widgets/streak_display.dart';
import '../widgets/action_buttons.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitState = ref.watch(habitProvider);
    final timerState = ref.watch(timerProvider);

    return Scaffold(
      body: SafeArea(
        child: habitState.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header
                    _buildHeader(context),
                    const SizedBox(height: 40),

                    // Main timer display
                    TimerDisplay(
                      currentTimerMinutes:
                          habitState.profile.currentTimerMinutes,
                      timerState: timerState,
                      onStartTimer: () {
                        ref
                            .read(timerProvider.notifier)
                            .startTimer(habitState.profile.currentTimerMinutes);
                      },
                    ).animate().fadeIn(duration: 600.ms).scale(),
                    const SizedBox(height: 40),

                    // Streak display
                    StreakDisplay(
                      goodStreak: habitState.profile.goodStreak,
                      badStreak: habitState.profile.badStreak,
                    ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
                    const SizedBox(height: 40),

                    // Statistics card
                    _buildStatisticsCard(
                      context,
                      habitState,
                    ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
                    const SizedBox(height: 24),

                    // Action buttons (if timer is active and complete)
                    if (timerState.remainingSeconds == 0 &&
                        !timerState.isRunning)
                      ActionButtons(
                        onRelapse: () async {
                          await ref
                              .read(habitProvider.notifier)
                              .recordRelapse();
                          ref.read(timerProvider.notifier).stopTimer();
                        },
                        onSuccess: () async {
                          await ref
                              .read(habitProvider.notifier)
                              .recordSuccess();
                          ref.read(timerProvider.notifier).stopTimer();
                        },
                      ).animate().fadeIn(delay: 600.ms),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.spa_outlined, color: AppTheme.primaryColor, size: 32),
            const SizedBox(width: 12),
            Text('Habitimer', style: Theme.of(context).textTheme.headlineLarge),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Break habits, build capacity',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildStatisticsCard(BuildContext context, HabitState habitState) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.bar_chart_rounded,
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Your Progress',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildStatRow(
              context,
              Icons.check_circle_outline,
              'Successes',
              habitState.profile.totalSuccesses.toString(),
              AppTheme.successColor,
            ),
            const SizedBox(height: 12),
            _buildStatRow(
              context,
              Icons.refresh,
              'Relapses',
              habitState.profile.totalRelapses.toString(),
              AppTheme.warningColor,
            ),
            const SizedBox(height: 12),
            _buildStatRow(
              context,
              Icons.timer_outlined,
              'Current Timer',
              '${habitState.profile.currentTimerMinutes} min',
              AppTheme.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(label, style: Theme.of(context).textTheme.bodyLarge),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}
