import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onRelapse;
  final VoidCallback onSuccess;

  const ActionButtons({
    super.key,
    required this.onRelapse,
    required this.onSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'How did it go?',
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        
        // Success button
        ElevatedButton.icon(
          onPressed: onSuccess,
          icon: const Icon(Icons.check_circle_outline),
          label: const Text('I Resisted 💪'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.successColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 20),
          ),
        ).animate().slideX(begin: 0.2, duration: 400.ms),
        
        const SizedBox(height: 16),
        
        // Relapse button
        OutlinedButton.icon(
          onPressed: onRelapse,
          icon: const Icon(Icons.refresh),
          label: const Text('I Relapsed (That\'s Okay)'),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppTheme.textSecondaryColor,
            padding: const EdgeInsets.symmetric(vertical: 20),
            side: BorderSide(color: AppTheme.textSecondaryColor.withValues(alpha: 0.3)),
          ),
        ).animate().slideX(begin: -0.2, duration: 400.ms),
      ],
    );
  }
}
