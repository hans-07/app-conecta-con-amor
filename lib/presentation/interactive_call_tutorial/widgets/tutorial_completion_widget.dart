import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TutorialCompletionWidget extends StatefulWidget {
  final VoidCallback onRepeat;
  final VoidCallback onNext;
  final VoidCallback onExit;

  const TutorialCompletionWidget({
    Key? key,
    required this.onRepeat,
    required this.onNext,
    required this.onExit,
  }) : super(key: key);

  @override
  State<TutorialCompletionWidget> createState() =>
      _TutorialCompletionWidgetState();
}

class _TutorialCompletionWidgetState extends State<TutorialCompletionWidget>
    with TickerProviderStateMixin {
  late AnimationController _celebrationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _celebrationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _celebrationController,
      curve: Curves.elasticOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.5,
    ).animate(CurvedAnimation(
      parent: _celebrationController,
      curve: Curves.easeInOut,
    ));

    _celebrationController.forward();
    HapticFeedback.mediumImpact();
  }

  @override
  void dispose() {
    _celebrationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppTheme.successFeedback.withValues(alpha: 0.1),
            AppTheme.lightTheme.colorScheme.surface,
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            children: [
              SizedBox(height: 8.h),
              // Celebration icon
              AnimatedBuilder(
                animation: _celebrationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Transform.rotate(
                      angle: _rotationAnimation.value * 2 * 3.14159,
                      child: Container(
                        width: 30.w,
                        height: 30.w,
                        decoration: BoxDecoration(
                          color:
                              AppTheme.successFeedback.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppTheme.successFeedback,
                            width: 3,
                          ),
                        ),
                        child: Center(
                          child: CustomIconWidget(
                            iconName: 'check_circle',
                            color: AppTheme.successFeedback,
                            size: 64,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 4.h),
              // Completion message
              Text(
                '¡Felicitaciones!',
                style: AppTheme.lightTheme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.successFeedback,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 2.h),
              Text(
                'Has completado exitosamente el tutorial de llamadas',
                style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4.h),
              // Achievement summary
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: AppTheme.successFeedback.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.successFeedback.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'Lo que has aprendido:',
                      style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.successFeedback,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    _buildAchievementItem('Cómo marcar números en el teclado'),
                    _buildAchievementItem('Cómo iniciar una llamada'),
                    _buildAchievementItem(
                        'Cómo usar los controles durante la llamada'),
                    _buildAchievementItem('Cómo finalizar una llamada'),
                  ],
                ),
              ),
              const Spacer(),
              // Action buttons
              Column(
                children: [
                  // Repeat tutorial
                  SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        widget.onRepeat();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        decoration: BoxDecoration(
                          color: AppTheme.lightTheme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppTheme.phoneAction,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomIconWidget(
                                iconName: 'replay',
                                color: AppTheme.phoneAction,
                                size: 24,
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                'Repetir Tutorial',
                                style: AppTheme.lightTheme.textTheme.titleLarge
                                    ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.phoneAction,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  // Next tutorial
                  SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        widget.onNext();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        decoration: BoxDecoration(
                          color: AppTheme.phoneAction,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  AppTheme.phoneAction.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomIconWidget(
                                iconName: 'arrow_forward',
                                color: AppTheme.backgroundPrimary,
                                size: 24,
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                'Siguiente Tutorial',
                                style: AppTheme.lightTheme.textTheme.titleLarge
                                    ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.backgroundPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  // Exit to home
                  SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        widget.onExit();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        decoration: BoxDecoration(
                          color: AppTheme.textSecondary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppTheme.borderSubtle,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomIconWidget(
                                iconName: 'home',
                                color: AppTheme.textSecondary,
                                size: 24,
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                'Volver al Inicio',
                                style: AppTheme.lightTheme.textTheme.titleLarge
                                    ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAchievementItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: 'check',
            color: AppTheme.successFeedback,
            size: 20,
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Text(
              text,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
