import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations for the senior-focused mobile application.
/// Implements high-contrast accessibility design with WCAG AA compliance.
class AppTheme {
  AppTheme._();

  // High-Contrast Accessibility Palette - Strategic color implementation optimized for aging vision
  static const Color primaryEmergency =
      Color(0xFFDC143C); // Critical action color for emergency calling
  static const Color emergencyBackground =
      Color(0xFFFFB6C1); // Soft pink background for emergency sections
  static const Color phoneAction =
      Color(0xFF228B22); // Forest green for calling functions
  static const Color messageCameraAction =
      Color(0xFF8A2BE2); // Blue violet for secondary communication
  static const Color contactsAction =
      Color(0xFF8B4513); // Saddle brown for contact management
  static const Color backgroundPrimary =
      Color(0xFFFFFFFF); // Pure white for maximum contrast
  static const Color textPrimary =
      Color(0xFF000000); // Pure black for optimal readability
  static const Color textSecondary =
      Color(0xFF333333); // Dark gray for supporting text
  static const Color borderSubtle =
      Color(0xFFE0E0E0); // Light gray for minimal visual separation
  static const Color successFeedback =
      Color(0xFF4CAF50); // Material green for positive confirmation

  // Dark theme colors (maintaining accessibility standards)
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFCCCCCC);
  static const Color borderSubtleDark = Color(0xFF404040);

  // Shadow and elevation colors
  static const Color shadowLight = Color(0x1F000000);
  static const Color shadowDark = Color(0x1FFFFFFF);

  /// Light theme optimized for senior users with high contrast and large touch targets
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: phoneAction,
      onPrimary: backgroundPrimary,
      primaryContainer: phoneAction,
      onPrimaryContainer: backgroundPrimary,
      secondary: messageCameraAction,
      onSecondary: backgroundPrimary,
      secondaryContainer: messageCameraAction,
      onSecondaryContainer: backgroundPrimary,
      tertiary: contactsAction,
      onTertiary: backgroundPrimary,
      tertiaryContainer: contactsAction,
      onTertiaryContainer: backgroundPrimary,
      error: primaryEmergency,
      onError: backgroundPrimary,
      surface: backgroundPrimary,
      onSurface: textPrimary,
      onSurfaceVariant: textSecondary,
      outline: borderSubtle,
      outlineVariant: borderSubtle,
      shadow: shadowLight,
      scrim: shadowLight,
      inverseSurface: backgroundDark,
      onInverseSurface: textPrimaryDark,
      inversePrimary: phoneAction,
    ),
    scaffoldBackgroundColor: backgroundPrimary,
    cardColor: backgroundPrimary,
    dividerColor: borderSubtle,

    // AppBar theme with high contrast and accessibility focus
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundPrimary,
      foregroundColor: textPrimary,
      elevation: 2.0, // Minimal elevation for subtle depth
      titleTextStyle: GoogleFonts.roboto(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: textPrimary,
      ),
      iconTheme: const IconThemeData(
        color: textPrimary,
        size: 32, // Large icons for accessibility
      ),
      actionsIconTheme: const IconThemeData(
        color: textPrimary,
        size: 32,
      ),
    ),



    // Bottom navigation optimized for seniors with large touch targets
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: backgroundPrimary,
      selectedItemColor: phoneAction,
      unselectedItemColor: textSecondary,
      selectedLabelStyle: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      type: BottomNavigationBarType.fixed,
      elevation: 4.0,
    ),

    // Emergency action button theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryEmergency,
      foregroundColor: backgroundPrimary,
      elevation: 4.0,
      extendedSizeConstraints: BoxConstraints(
        minHeight: 60, // Large touch target
        minWidth: 60,
      ),
    ),

    // Elevated button theme with large touch targets
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: backgroundPrimary,
        backgroundColor: phoneAction,
        minimumSize: const Size(120, 60), // Large touch targets
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 2.0,
        textStyle: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Outlined button theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: phoneAction,
        minimumSize: const Size(120, 60),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        side: const BorderSide(color: phoneAction, width: 2.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Text button theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: phoneAction,
        minimumSize: const Size(120, 60),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Text theme with accessibility-focused typography
    textTheme: _buildTextTheme(isLight: true),

    // Input decoration with high contrast borders
    inputDecorationTheme: InputDecorationTheme(
      fillColor: backgroundPrimary,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: borderSubtle, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: borderSubtle, width: 2.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: phoneAction, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: primaryEmergency, width: 2.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: primaryEmergency, width: 2.0),
      ),
      labelStyle: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textSecondary,
      ),
      hintStyle: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textSecondary,
      ),
    ),

    // Switch theme with high contrast
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return phoneAction;
        }
        return borderSubtle;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return phoneAction.withValues(alpha: 0.5);
        }
        return borderSubtle.withValues(alpha: 0.5);
      }),
    ),

    // Checkbox theme
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return phoneAction;
        }
        return backgroundPrimary;
      }),
      checkColor: WidgetStateProperty.all(backgroundPrimary),
      side: const BorderSide(color: borderSubtle, width: 2.0),
    ),

    // Radio theme
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return phoneAction;
        }
        return borderSubtle;
      }),
    ),

    // Progress indicator theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: phoneAction,
      linearTrackColor: borderSubtle,
    ),

    // Slider theme
    sliderTheme: SliderThemeData(
      activeTrackColor: phoneAction,
      thumbColor: phoneAction,
      overlayColor: phoneAction.withValues(alpha: 0.2),
      inactiveTrackColor: borderSubtle,
      trackHeight: 8.0,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
    ),

    // Tooltip theme
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: textPrimary.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8.0),
      ),
      textStyle: GoogleFonts.openSans(
        color: backgroundPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    // Snackbar theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: textPrimary,
      contentTextStyle: GoogleFonts.openSans(
        color: backgroundPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      actionTextColor: successFeedback,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 4.0,
    ), dialogTheme: DialogThemeData(backgroundColor: backgroundPrimary),
  );

  /// Dark theme with maintained accessibility standards
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: phoneAction,
      onPrimary: textPrimaryDark,
      primaryContainer: phoneAction,
      onPrimaryContainer: textPrimaryDark,
      secondary: messageCameraAction,
      onSecondary: textPrimaryDark,
      secondaryContainer: messageCameraAction,
      onSecondaryContainer: textPrimaryDark,
      tertiary: contactsAction,
      onTertiary: textPrimaryDark,
      tertiaryContainer: contactsAction,
      onTertiaryContainer: textPrimaryDark,
      error: primaryEmergency,
      onError: textPrimaryDark,
      surface: surfaceDark,
      onSurface: textPrimaryDark,
      onSurfaceVariant: textSecondaryDark,
      outline: borderSubtleDark,
      outlineVariant: borderSubtleDark,
      shadow: shadowDark,
      scrim: shadowDark,
      inverseSurface: backgroundPrimary,
      onInverseSurface: textPrimary,
      inversePrimary: phoneAction,
    ),
    scaffoldBackgroundColor: backgroundDark,
    cardColor: surfaceDark,
    dividerColor: borderSubtleDark,

    // AppBar theme for dark mode
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceDark,
      foregroundColor: textPrimaryDark,
      elevation: 2.0,
      titleTextStyle: GoogleFonts.roboto(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: textPrimaryDark,
      ),
      iconTheme: const IconThemeData(
        color: textPrimaryDark,
        size: 32,
      ),
      actionsIconTheme: const IconThemeData(
        color: textPrimaryDark,
        size: 32,
      ),
    ),


    // Bottom navigation for dark mode
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceDark,
      selectedItemColor: phoneAction,
      unselectedItemColor: textSecondaryDark,
      selectedLabelStyle: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      type: BottomNavigationBarType.fixed,
      elevation: 4.0,
    ),

    // Emergency action button for dark mode
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryEmergency,
      foregroundColor: textPrimaryDark,
      elevation: 4.0,
      extendedSizeConstraints: BoxConstraints(
        minHeight: 60,
        minWidth: 60,
      ),
    ),

    // Button themes for dark mode
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: textPrimaryDark,
        backgroundColor: phoneAction,
        minimumSize: const Size(120, 60),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 2.0,
        textStyle: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: phoneAction,
        minimumSize: const Size(120, 60),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        side: const BorderSide(color: phoneAction, width: 2.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: phoneAction,
        minimumSize: const Size(120, 60),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    textTheme: _buildTextTheme(isLight: false),

    // Input decoration for dark mode
    inputDecorationTheme: InputDecorationTheme(
      fillColor: surfaceDark,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: borderSubtleDark, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: borderSubtleDark, width: 2.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: phoneAction, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: primaryEmergency, width: 2.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: primaryEmergency, width: 2.0),
      ),
      labelStyle: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textSecondaryDark,
      ),
      hintStyle: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textSecondaryDark,
      ),
    ),

    // Additional dark mode theme configurations
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return phoneAction;
        }
        return borderSubtleDark;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return phoneAction.withValues(alpha: 0.5);
        }
        return borderSubtleDark.withValues(alpha: 0.5);
      }),
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return phoneAction;
        }
        return surfaceDark;
      }),
      checkColor: WidgetStateProperty.all(textPrimaryDark),
      side: const BorderSide(color: borderSubtleDark, width: 2.0),
    ),

    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return phoneAction;
        }
        return borderSubtleDark;
      }),
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: phoneAction,
      linearTrackColor: borderSubtleDark,
    ),

    sliderTheme: SliderThemeData(
      activeTrackColor: phoneAction,
      thumbColor: phoneAction,
      overlayColor: phoneAction.withValues(alpha: 0.2),
      inactiveTrackColor: borderSubtleDark,
      trackHeight: 8.0,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
    ),


    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: textPrimaryDark.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8.0),
      ),
      textStyle: GoogleFonts.openSans(
        color: backgroundDark,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: textPrimaryDark,
      contentTextStyle: GoogleFonts.openSans(
        color: backgroundDark,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      actionTextColor: successFeedback,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 4.0,
    ), dialogTheme: DialogThemeData(backgroundColor: surfaceDark),
  );

  /// Helper method to build text theme with accessibility-focused typography
  static TextTheme _buildTextTheme({required bool isLight}) {
    final Color textHighEmphasis = isLight ? textPrimary : textPrimaryDark;
    final Color textMediumEmphasis =
        isLight ? textSecondary : textSecondaryDark;
    final Color textDisabled = isLight
        ? textSecondary.withValues(alpha: 0.6)
        : textSecondaryDark.withValues(alpha: 0.6);

    return TextTheme(
      // Display styles - Roboto Bold for headings
      displayLarge: GoogleFonts.roboto(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        color: textHighEmphasis,
        letterSpacing: -0.5,
      ),
      displayMedium: GoogleFonts.roboto(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: textHighEmphasis,
        letterSpacing: -0.25,
      ),
      displaySmall: GoogleFonts.roboto(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: textHighEmphasis,
      ),

      // Headline styles - Roboto Bold for section headers
      headlineLarge: GoogleFonts.roboto(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: textHighEmphasis,
        letterSpacing: 0.25,
      ),
      headlineMedium: GoogleFonts.roboto(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: textHighEmphasis,
      ),
      headlineSmall: GoogleFonts.roboto(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textHighEmphasis,
      ),

      // Title styles - Roboto Medium for UI elements
      titleLarge: GoogleFonts.roboto(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textHighEmphasis,
        letterSpacing: 0.15,
      ),
      titleMedium: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textHighEmphasis,
        letterSpacing: 0.15,
      ),
      titleSmall: GoogleFonts.roboto(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textHighEmphasis,
        letterSpacing: 0.1,
      ),

      // Body styles - Open Sans for readability
      bodyLarge: GoogleFonts.openSans(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
        letterSpacing: 0.5,
        height: 1.5,
      ),
      bodyMedium: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
        letterSpacing: 0.25,
        height: 1.4,
      ),
      bodySmall: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textMediumEmphasis,
        letterSpacing: 0.4,
        height: 1.3,
      ),

      // Label styles - Roboto for UI labels and captions
      labelLarge: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textHighEmphasis,
        letterSpacing: 1.25,
      ),
      labelMedium: GoogleFonts.roboto(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textMediumEmphasis,
        letterSpacing: 0.4,
      ),
      labelSmall: GoogleFonts.roboto(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textDisabled,
        letterSpacing: 1.5,
      ),
    );
  }
}
