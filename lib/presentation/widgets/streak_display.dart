import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';

class StreakDisplay extends StatelessWidget {
  final int goodStreak;
  final int badStreak;

  const StreakDisplay({
    super.key,
    required this.goodStreak,
    required this.badStreak,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStreakCard(
            context,
            title: 'Good Streak',
            streak: goodStreak,
            icon: Icons.local_fire_department,
            color: AppTheme.successColor,
            gradient: AppTheme.successGradient,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStreakCard(
            context,
            title: 'Bad Streak',
            streak: badStreak,
            icon: Icons.warning_amber_rounded,
            color: AppTheme.warningColor,
            gradient: null,
          ),
        ),
      ],
    );
  }

  Widget _buildStreakCard(
    BuildContext context, {
    required String title,
    required int streak,
    required IconData icon,
    required Color color,
    LinearGradient? gradient,
  }) {
    return Card(
      elevation: gradient != null ? 3 : 1,
      shadowColor: gradient != null ? color.withValues(alpha: 0.3) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28), // Material 3 Expressive
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: gradient != null ? Colors.white : color,
              size: 36,
            ).animate(onPlay: (controller) {
              if (streak > 0 && gradient != null) {
                controller.repeat();
              }
            }).shimmer(
              duration: 1500.ms,
              color: Colors.white.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: gradient != null ? Colors.white.withValues(alpha: 0.95) : null,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              '$streak',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: 42,
                    color: gradient != null ? Colors.white : color,
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              streak == 1 ? 'day' : 'days',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: gradient != null ? Colors.white.withValues(alpha: 0.8) : AppTheme.textSecondaryColor,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
