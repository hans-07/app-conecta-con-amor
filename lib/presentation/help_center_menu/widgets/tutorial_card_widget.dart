import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TutorialCardWidget extends StatelessWidget {
  final String iconName;
  final String title;
  final String description;
  final String duration;
  final bool isCompleted;
  final VoidCallback onTap;

  const TutorialCardWidget({
    Key? key,
    required this.iconName,
    required this.title,
    required this.description,
    required this.duration,
    required this.isCompleted,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            onTap();
          },
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: isCompleted
                    ? AppTheme.successFeedback
                    : AppTheme.lightTheme.colorScheme.outline,
                width: isCompleted ? 2.0 : 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.lightTheme.colorScheme.shadow
                      .withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Icon container
                Container(
                  width: 16.w,
                  height: 16.w,
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? AppTheme.successFeedback
                        : AppTheme.lightTheme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: CustomIconWidget(
                          iconName: iconName,
                          color: AppTheme.lightTheme.colorScheme.surface,
                          size: 8.w,
                        ),
                      ),
                      if (isCompleted)
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 5.w,
                            height: 5.w,
                            decoration: BoxDecoration(
                              color: AppTheme.lightTheme.colorScheme.surface,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Icon(
                              Icons.check,
                              color: AppTheme.successFeedback,
                              size: 3.w,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                SizedBox(width: 4.w),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: AppTheme.lightTheme.textTheme.titleMedium
                                  ?.copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color:
                                    AppTheme.lightTheme.colorScheme.onSurface,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 0.5.h),
                            decoration: BoxDecoration(
                              color: isCompleted
                                  ? AppTheme.successFeedback
                                      .withValues(alpha: 0.1)
                                  : AppTheme.lightTheme.colorScheme.primary
                                      .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Text(
                              isCompleted ? 'Completado' : 'Nuevo',
                              style: AppTheme.lightTheme.textTheme.labelSmall
                                  ?.copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: isCompleted
                                    ? AppTheme.successFeedback
                                    : AppTheme.lightTheme.colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        description,
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          fontSize: 16.sp,
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'access_time',
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                            size: 4.w,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            duration,
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              fontSize: 14.sp,
                              color: AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const Spacer(),
                          CustomIconWidget(
                            iconName: 'arrow_forward',
                            color: AppTheme.lightTheme.colorScheme.primary,
                            size: 5.w,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
