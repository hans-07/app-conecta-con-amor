import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final int completedTutorials;
  final int totalTutorials;

  const ProgressIndicatorWidget({
    Key? key,
    required this.completedTutorials,
    required this.totalTutorials,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double progressPercentage =
        totalTutorials > 0 ? (completedTutorials / totalTutorials) : 0.0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 4.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon and title
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: AppTheme.successFeedback.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: CustomIconWidget(
                  iconName: 'trending_up',
                  color: AppTheme.successFeedback,
                  size: 6.w,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tu Progreso de Aprendizaje',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.lightTheme.colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      '$completedTutorials de $totalTutorials tutoriales completados',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        fontSize: 12.sp,
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 3.h),

          // Progress bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Progreso General',
                    style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    '${(progressPercentage * 100).toInt()}%',
                    style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.successFeedback,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h),

              // Progress bar track
              Container(
                height: 1.h,
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progressPercentage,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.successFeedback,
                          AppTheme.lightTheme.colorScheme.primary,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 2.h),

          // Achievement badges
          if (completedTutorials > 0) ...[
            Row(
              children: [
                // Beginner badge
                if (completedTutorials >= 1) ...[
                  _buildAchievementBadge(
                    'Principiante',
                    'star',
                    AppTheme.lightTheme.colorScheme.primary,
                  ),
                  SizedBox(width: 2.w),
                ],

                // Intermediate badge
                if (completedTutorials >= 3) ...[
                  _buildAchievementBadge(
                    'Intermedio',
                    'star_half',
                    AppTheme.messageCameraAction,
                  ),
                  SizedBox(width: 2.w),
                ],

                // Expert badge
                if (completedTutorials >= 5) ...[
                  _buildAchievementBadge(
                    'Experto',
                    'stars',
                    AppTheme.successFeedback,
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAchievementBadge(String title, String iconName, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color, width: 1.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIconWidget(
            iconName: iconName,
            color: color,
            size: 4.w,
          ),
          SizedBox(width: 1.w),
          Text(
            title,
            style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
