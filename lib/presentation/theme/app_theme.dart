import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Material 3 Expressive theme - calm and supportive
class AppTheme {
  // Material 3 Expressive Color Palette (Calm variant)
  static const Color primaryColor = Color(
    0xFF5B9FED,
  ); // Softer, more expressive blue
  static const Color secondaryColor = Color(0xFF6BCF7E); // Vibrant gentle green
  static const Color tertiaryColor = Color(0xFFF8B84E); // Warm expressive amber
  static const Color backgroundColor = Color(0xFFFCFCFF); // Cool white
  static const Color surfaceColor = Color(0xFFFFFFFF); // Pure white
  static const Color surfaceContainerColor = Color(
    0xFFF4F7FC,
  ); // Light container
  static const Color textPrimaryColor = Color(0xFF1A1C1E); // Near black
  static const Color textSecondaryColor = Color(0xFF5F6368); // Medium gray
  static const Color successColor = Color(0xFF34C759); // iOS-style green
  static const Color errorColor = Color(0xFFFF6B6B); // Soft vibrant red
  static const Color warningColor = Color(0xFFFFB547); // Warm amber

  // Material 3 Expressive gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF5B9FED), Color(0xFF4A7FD9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0xFF6BCF7E), Color(0xFF34C759)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    colors: [Color(0xFFF8FAFF), Color(0xFFFFFFFF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Material 3 Expressive Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    // Color Scheme with expressive colors
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      onPrimary: Colors.white,
      primaryContainer: const Color(0xFFD9E9FF),
      onPrimaryContainer: const Color(0xFF001D35),

      secondary: secondaryColor,
      onSecondary: Colors.white,
      secondaryContainer: const Color(0xFFD9F7E0),
      onSecondaryContainer: const Color(0xFF002110),

      tertiary: tertiaryColor,
      onTertiary: Colors.white,
      tertiaryContainer: const Color(0xFFFFEFD6),
      onTertiaryContainer: const Color(0xFF2A1800),

      error: errorColor,
      onError: Colors.white,
      errorContainer: const Color(0xFFFFDAD6),
      onErrorContainer: const Color(0xFF410002),

      surface: surfaceColor,
      onSurface: textPrimaryColor,
      surfaceContainerLowest: const Color(0xFFFFFFFF),
      surfaceContainerLow: surfaceContainerColor,
      surfaceContainer: const Color(0xFFEEF1F6),
      surfaceContainerHigh: const Color(0xFFE8EBF0),
      surfaceContainerHighest: const Color(0xFFE2E5EA),

      outline: const Color(0xFFC4C7CC),
      outlineVariant: const Color(0xFFE1E3E8),
    ),

    scaffoldBackgroundColor: backgroundColor,

    // Material 3 Expressive Typography with rounded, friendly fonts
    textTheme: GoogleFonts.plusJakartaSansTextTheme().copyWith(
      // Display styles - bold and expressive
      displayLarge: GoogleFonts.plusJakartaSans(
        fontSize: 57,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
        color: textPrimaryColor,
      ),
      displayMedium: GoogleFonts.plusJakartaSans(
        fontSize: 45,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        color: textPrimaryColor,
      ),
      displaySmall: GoogleFonts.plusJakartaSans(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: textPrimaryColor,
      ),

      // Headline styles
      headlineLarge: GoogleFonts.plusJakartaSans(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: textPrimaryColor,
      ),
      headlineMedium: GoogleFonts.plusJakartaSans(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: textPrimaryColor,
      ),
      headlineSmall: GoogleFonts.plusJakartaSans(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textPrimaryColor,
      ),

      // Body styles
      bodyLarge: GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: textPrimaryColor,
      ),
      bodyMedium: GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: textSecondaryColor,
      ),
      bodySmall: GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: textSecondaryColor,
      ),

      // Label styles
      labelLarge: GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ),
      labelMedium: GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    ),

    // Material 3 Expressive Buttons - extra rounded and vibrant
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28), // Expressive: extra rounded
        ),
        elevation: 2,
        shadowColor: primaryColor.withValues(alpha: 0.3),
        textStyle: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: textPrimaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        side: BorderSide(
          color: textSecondaryColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
    ),

    // Material 3 Expressive Cards - large rounded corners
    cardTheme: CardThemeData(
      color: surfaceColor,
      elevation: 1,
      shadowColor: Colors.black.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32), // Expressive: very rounded
      ),
      clipBehavior: Clip.antiAlias,
    ),

    // AppBar with expressive style
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.plusJakartaSans(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: textPrimaryColor,
        letterSpacing: 0.5,
      ),
      iconTheme: const IconThemeData(color: textPrimaryColor, size: 24),
    ),

    // Icon theme
    iconTheme: const IconThemeData(color: primaryColor, size: 24),

    // Floating Action Button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24), // Expressive rounded
      ),
    ),

    // Divider
    dividerTheme: DividerThemeData(
      color: const Color(0xFFE1E3E8),
      thickness: 1,
      space: 1,
    ),
  );

  // Dark theme placeholder (for future implementation)
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    // TODO: Implement Material 3 Expressive dark theme
  );
}
