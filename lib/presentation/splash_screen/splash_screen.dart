import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _initializeApp();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
    ));

    _animationController.forward();
  }

  Future<void> _initializeApp() async {
    try {
      // Hide system status bar for full-screen experience
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

      // Simulate initialization tasks
      await Future.wait([
        _checkPermissions(),
        _loadUserPreferences(),
        _prepareEmergencyContacts(),
        _initializeAccessibilityServices(),
      ]);

      // Minimum splash duration for branding
      await Future.delayed(const Duration(milliseconds: 3000));

      setState(() {
        _isInitialized = true;
      });

      // Provide haptic feedback
      HapticFeedback.lightImpact();

      // Navigate to appropriate screen
      _navigateToNextScreen();
    } catch (e) {
      // Handle initialization errors gracefully
      _handleInitializationError();
    }
  }

  Future<void> _checkPermissions() async {
    // Simulate permission checking
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> _loadUserPreferences() async {
    // Simulate loading user preferences
    await Future.delayed(const Duration(milliseconds: 300));
  }

  Future<void> _prepareEmergencyContacts() async {
    // Simulate preparing emergency contacts
    await Future.delayed(const Duration(milliseconds: 400));
  }

  Future<void> _initializeAccessibilityServices() async {
    // Simulate accessibility services initialization
    await Future.delayed(const Duration(milliseconds: 600));
  }

  void _navigateToNextScreen() {
    // Restore system UI before navigation
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    // Navigate to main launcher home
    Navigator.pushReplacementNamed(context, '/main-launcher-home');
  }

  void _handleInitializationError() {
    // Show error dialog and retry option
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Error de Inicialización',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.primaryEmergency,
            ),
          ),
          content: Text(
            'Hubo un problema al inicializar la aplicación. ¿Desea intentar nuevamente?',
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _initializeApp();
              },
              child: Text(
                'Reintentar',
                style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                  color: AppTheme.phoneAction,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.emergencyBackground,
              AppTheme.emergencyBackground.withValues(alpha: 0.8),
              AppTheme.backgroundPrimary,
            ],
            stops: const [0.0, 0.6, 1.0],
          ),
        ),
        child: SafeArea(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Main logo and branding section
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // App icon/logo placeholder
                            Container(
                              width: 25.w,
                              height: 25.w,
                              decoration: BoxDecoration(
                                color: AppTheme.phoneAction,
                                borderRadius: BorderRadius.circular(4.w),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.shadowLight,
                                    blurRadius: 8.0,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: CustomIconWidget(
                                  iconName: 'phone',
                                  color: AppTheme.backgroundPrimary,
                                  size: 12.w,
                                ),
                              ),
                            ),
                            SizedBox(height: 4.h),

                            // Main title
                            Text(
                              'Mi Teléfono',
                              style: AppTheme.lightTheme.textTheme.displayMedium
                                  ?.copyWith(
                                color: AppTheme.textPrimary,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 1.h),

                            // Subtitle
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Text(
                                'Teléfono Fácil para Personas Mayores',
                                style: AppTheme.lightTheme.textTheme.titleLarge
                                    ?.copyWith(
                                  color: AppTheme.textSecondary,
                                  fontWeight: FontWeight.w500,
                                  height: 1.3,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Loading section
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Loading indicator
                            SizedBox(
                              width: 8.w,
                              height: 8.w,
                              child: CircularProgressIndicator(
                                strokeWidth: 0.8.w,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppTheme.phoneAction,
                                ),
                                backgroundColor: AppTheme.borderSubtle,
                              ),
                            ),
                            SizedBox(height: 2.h),

                            // Loading text
                            Text(
                              _isInitialized
                                  ? 'Iniciando...'
                                  : 'Preparando su teléfono...',
                              style: AppTheme.lightTheme.textTheme.bodyLarge
                                  ?.copyWith(
                                color: AppTheme.textSecondary,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

                      // Version and copyright info
                      Padding(
                        padding: EdgeInsets.only(bottom: 2.h),
                        child: Column(
                          children: [
                            Text(
                              'Versión 1.0.0',
                              style: AppTheme.lightTheme.textTheme.labelSmall
                                  ?.copyWith(
                                color: AppTheme.textSecondary
                                    .withValues(alpha: 0.7),
                              ),
                            ),
                            SizedBox(height: 0.5.h),
                            Text(
                              '© 2025 Mi Teléfono - Diseñado para Personas Mayores',
                              style: AppTheme.lightTheme.textTheme.labelSmall
                                  ?.copyWith(
                                color: AppTheme.textSecondary
                                    .withValues(alpha: 0.7),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
