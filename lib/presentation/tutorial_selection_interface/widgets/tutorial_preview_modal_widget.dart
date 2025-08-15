import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TutorialPreviewModalWidget extends StatelessWidget {
  final Map<String, dynamic> tutorial;
  final VoidCallback onStart;
  final VoidCallback onClose;

  const TutorialPreviewModalWidget({
    Key? key,
    required this.tutorial,
    required this.onStart,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String title = tutorial['title'] as String? ?? '';
    final String description = tutorial['description'] as String? ?? '';
    final String difficulty = tutorial['difficulty'] as String? ?? 'Básico';
    final String duration = tutorial['duration'] as String? ?? '5 min';
    final String iconName = tutorial['icon'] as String? ?? 'help';
    final List<String> objectives =
        (tutorial['objectives'] as List?)?.cast<String>() ?? [];

    return Dialog(
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: 80.h,
          maxWidth: 90.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.phoneAction.withValues(alpha: 0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: AppTheme.phoneAction,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CustomIconWidget(
                      iconName: iconName,
                      color: AppTheme.lightTheme.colorScheme.onPrimary,
                      size: 8.w,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTheme.lightTheme.textTheme.titleLarge
                              ?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 0.5.h),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.w,
                                vertical: 0.5.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.phoneAction,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                difficulty,
                                style: AppTheme.lightTheme.textTheme.labelSmall
                                    ?.copyWith(
                                  color:
                                      AppTheme.lightTheme.colorScheme.onPrimary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11.sp,
                                ),
                              ),
                            ),
                            SizedBox(width: 2.w),
                            CustomIconWidget(
                              iconName: 'access_time',
                              color: AppTheme.textSecondary,
                              size: 4.w,
                            ),
                            SizedBox(width: 1.w),
                            Text(
                              duration,
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: onClose,
                    child: Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        color: AppTheme.textSecondary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: CustomIconWidget(
                        iconName: 'close',
                        color: AppTheme.textSecondary,
                        size: 6.w,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Descripción',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      description,
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        height: 1.5,
                      ),
                    ),
                    if (objectives.isNotEmpty) ...[
                      SizedBox(height: 3.h),
                      Text(
                        'Objetivos de Aprendizaje',
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      ...objectives
                          .map((objective) => Padding(
                                padding: EdgeInsets.only(bottom: 1.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 0.5.h),
                                      child: CustomIconWidget(
                                        iconName: 'check_circle',
                                        color: AppTheme.successFeedback,
                                        size: 4.w,
                                      ),
                                    ),
                                    SizedBox(width: 2.w),
                                    Expanded(
                                      child: Text(
                                        objective,
                                        style: AppTheme
                                            .lightTheme.textTheme.bodyMedium
                                            ?.copyWith(
                                          fontSize: 14.sp,
                                          height: 1.4,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ],
                  ],
                ),
              ),
            ),

            // Action Button
            Container(
              padding: EdgeInsets.all(4.w),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onStart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.phoneAction,
                    foregroundColor: AppTheme.lightTheme.colorScheme.onPrimary,
                    minimumSize: Size(double.infinity, 7.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconWidget(
                        iconName: 'play_arrow',
                        color: AppTheme.lightTheme.colorScheme.onPrimary,
                        size: 6.w,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Comenzar Tutorial',
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
