import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EnhancedTutorialCardWidget extends StatelessWidget {
  final String iconName;
  final String title;
  final String description;
  final String duration;
  final bool isCompleted;
  final String category;
  final VoidCallback onTap;

  const EnhancedTutorialCardWidget({
    Key? key,
    required this.iconName,
    required this.title,
    required this.description,
    required this.duration,
    required this.isCompleted,
    required this.category,
    required this.onTap,
  }) : super(key: key);

  Color _getCategoryColor() {
    switch (category) {
      case 'comunicacion':
        return AppTheme.phoneAction;
      case 'multimedia':
        return AppTheme.messageCameraAction;
      case 'utilidades':
        return const Color(0xFF2196F3); // Blue
      case 'seguridad':
        return AppTheme.primaryEmergency;
      case 'salud':
        return const Color(0xFF4CAF50); // Green
      case 'entretenimiento':
        return const Color(0xFFFF9800); // Orange
      case 'informacion':
        return const Color(0xFF9C27B0); // Purple
      case 'conectividad':
        return const Color(0xFF00BCD4); // Cyan
      case 'configuracion':
        return AppTheme.contactsAction;
      default:
        return AppTheme.phoneAction;
    }
  }

  String _getCategoryDisplayName() {
    switch (category) {
      case 'comunicacion':
        return 'Comunicación';
      case 'multimedia':
        return 'Multimedia';
      case 'utilidades':
        return 'Utilidades';
      case 'seguridad':
        return 'Seguridad';
      case 'salud':
        return 'Salud';
      case 'entretenimiento':
        return 'Entretenimiento';
      case 'informacion':
        return 'Información';
      case 'conectividad':
        return 'Conectividad';
      case 'configuracion':
        return 'Configuración';
      default:
        return 'General';
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryColor = _getCategoryColor();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: isCompleted
              ? AppTheme.successFeedback.withValues(alpha: 0.3)
              : categoryColor.withValues(alpha: 0.2),
          width: 3.0, // Thicker border as requested
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            onTap();
          },
          borderRadius: BorderRadius.circular(16.0),
          child: Padding(
            padding: EdgeInsets.all(5.w), // Increased padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row with icon, title and completion status
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon container with enhanced size
                    Container(
                      width: 18.w,
                      height: 18.w,
                      decoration: BoxDecoration(
                        color: categoryColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          color: categoryColor.withValues(alpha: 0.3),
                          width: 2,
                        ),
                      ),
                      child: CustomIconWidget(
                        iconName: iconName,
                        color: categoryColor,
                        size: 9.w, // Oversized icons as requested
                      ),
                    ),

                    SizedBox(width: 4.w),

                    // Title and category
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: AppTheme.lightTheme.textTheme.titleLarge
                                ?.copyWith(
                              fontSize: 24.sp, // 24pt bold font as requested
                              fontWeight: FontWeight.w700,
                              color: AppTheme.lightTheme.colorScheme.onSurface,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 0.5.h),
                            decoration: BoxDecoration(
                              color: categoryColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: categoryColor.withValues(alpha: 0.3),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              _getCategoryDisplayName(),
                              style: AppTheme.lightTheme.textTheme.labelSmall
                                  ?.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: categoryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Completion status with larger visual cues
                    Container(
                      width: 12.w,
                      height: 12.w,
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? AppTheme.successFeedback
                            : AppTheme.lightTheme.colorScheme.outline
                                .withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: isCompleted
                              ? AppTheme.successFeedback
                              : AppTheme.lightTheme.colorScheme.outline,
                          width: 2,
                        ),
                      ),
                      child: CustomIconWidget(
                        iconName: isCompleted ? 'check' : 'play_arrow',
                        color: isCompleted
                            ? Colors.white
                            : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        size: 6.w,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 3.h),

                // Description with enhanced typography
                Text(
                  description,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    fontSize: 18.sp, // 18pt text as requested
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),

                SizedBox(height: 3.h),

                // Duration and action row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'schedule',
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                          size: 5.w,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          duration,
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            fontSize: 16.sp, // Larger duration text
                            fontWeight: FontWeight.w500,
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),

                    // Action button with enhanced design
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 4.w, vertical: 1.5.h),
                      decoration: BoxDecoration(
                        color: categoryColor,
                        borderRadius: BorderRadius.circular(25.0),
                        boxShadow: [
                          BoxShadow(
                            color: categoryColor.withValues(alpha: 0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomIconWidget(
                            iconName: isCompleted ? 'refresh' : 'play_arrow',
                            color: Colors.white,
                            size: 4.5.w,
                          ),
                          SizedBox(width: 1.5.w),
                          Text(
                            isCompleted ? 'Repetir' : 'Comenzar',
                            style: AppTheme.lightTheme.textTheme.labelMedium
                                ?.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
