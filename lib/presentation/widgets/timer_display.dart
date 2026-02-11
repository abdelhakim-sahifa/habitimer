import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/timer_provider.dart';
import '../theme/app_theme.dart';

class TimerDisplay extends StatelessWidget {
  final int currentTimerMinutes;
  final TimerState timerState;
  final VoidCallback onStartTimer;

  const TimerDisplay({
    super.key,
    required this.currentTimerMinutes,
    required this.timerState,
    required this.onStartTimer,
  });

  @override
  Widget build(BuildContext context) {
    final isTimerZero = currentTimerMinutes == 0;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(36), // Material 3 Expressive
      ),
      child: Container(
        padding: const EdgeInsets.all(36),
        decoration: BoxDecoration(
          gradient: timerState.isRunning ? AppTheme.primaryGradient : null,
          borderRadius: BorderRadius.circular(36),
        ),
        child: Column(
          children: [
            // Timer value
            if (timerState.isRunning)
              _buildActiveTimer(context)
            else
              _buildInactiveTimer(context, isTimerZero),

            const SizedBox(height: 28),

            // Action button
            if (!timerState.isRunning && !isTimerZero)
              _buildStartButton(context),

            if (isTimerZero) _buildZeroStateMessage(context),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveTimer(BuildContext context) {
    final minutes = timerState.remainingSeconds ~/ 60;
    final seconds = timerState.remainingSeconds % 60;

    return Column(
      children: [
        Icon(
              Icons.self_improvement,
              size: 64,
              color: Colors.white.withValues(alpha: 0.9),
            )
            .animate(onPlay: (controller) => controller.repeat())
            .shimmer(
              duration: 2000.ms,
              color: Colors.white.withValues(alpha: 0.3),
            ),
        const SizedBox(height: 16),
        Text(
          'Take a breath...',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 24),
        Text(
          '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontSize: 72,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        LinearProgressIndicator(
          value: timerState.remainingSeconds / (currentTimerMinutes * 60),
          backgroundColor: Colors.white.withValues(alpha: 0.3),
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ],
    );
  }

  Widget _buildInactiveTimer(BuildContext context, bool isZero) {
    return Column(
      children: [
        Icon(
          isZero ? Icons.celebration_outlined : Icons.timer_outlined,
          size: 64,
          color: isZero ? AppTheme.successColor : AppTheme.primaryColor,
        ),
        const SizedBox(height: 16),
        Text(
          isZero ? 'No Wait Time!' : 'Current Wait Time',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        Text(
          isZero ? '0:00' : '$currentTimerMinutes:00',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontSize: 72,
            color: isZero ? AppTheme.successColor : AppTheme.textPrimaryColor,
          ),
        ),
        if (!isZero) ...[
          const SizedBox(height: 8),
          Text('minutes', style: Theme.of(context).textTheme.bodyMedium),
        ],
      ],
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onStartTimer,
        icon: const Icon(Icons.play_arrow),
        label: const Text('Start Reflection Timer'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20),
        ),
      ),
    );
  }

  Widget _buildZeroStateMessage(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.successColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20), // Expressive rounded
      ),
      child: Row(
        children: [
          Icon(Icons.star_rounded, color: AppTheme.successColor, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'You\'ve built strong resistance! Keep it up! 💪',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.successColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
