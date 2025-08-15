import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EnhancedProgressIndicatorWidget extends StatelessWidget {
  final int completedTutorials;
  final int totalTutorials;

  const EnhancedProgressIndicatorWidget({
    Key? key,
    required this.completedTutorials,
    required this.totalTutorials,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progress =
        totalTutorials > 0 ? completedTutorials / totalTutorials : 0.0;
    final percentageComplete = (progress * 100).round();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1),
            AppTheme.successFeedback.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.2),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tu Progreso',
                    style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                      fontSize: 26.sp, // Larger header
                      fontWeight: FontWeight.w700,
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    '$completedTutorials de $totalTutorials completados',
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      fontSize: 18.sp, // Larger body text
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),

              // Large circular progress indicator
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 6.0, // Thicker progress ring
                      backgroundColor: AppTheme.lightTheme.colorScheme.outline
                          .withValues(alpha: 0.3),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        progress < 0.5
                            ? AppTheme.lightTheme.colorScheme.primary
                            : AppTheme.successFeedback,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$percentageComplete%',
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: progress < 0.5
                              ? AppTheme.lightTheme.colorScheme.primary
                              : AppTheme.successFeedback,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 3.h),

          // Enhanced linear progress bar
          Container(
            height: 3.h,
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.outline
                  .withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(
                  progress < 0.3
                      ? AppTheme.primaryEmergency
                      : progress < 0.7
                          ? AppTheme.lightTheme.colorScheme.primary
                          : AppTheme.successFeedback,
                ),
              ),
            ),
          ),

          SizedBox(height: 2.h),

          // Progress message with enhanced styling
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIconWidget(
                iconName: progress >= 1.0 ? 'celebration' : 'trending_up',
                color: progress >= 1.0
                    ? AppTheme.successFeedback
                    : AppTheme.lightTheme.colorScheme.primary,
                size: 6.w,
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: Text(
                  progress >= 1.0
                      ? '¡Felicitaciones! Has completado todos los tutoriales'
                      : progress >= 0.5
                          ? '¡Excelente progreso! Sigue así'
                          : 'Comienza tu aprendizaje, ¡puedes hacerlo!',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: progress >= 1.0
                        ? AppTheme.successFeedback
                        : AppTheme.lightTheme.colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
