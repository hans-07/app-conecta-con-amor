import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TutorialContextMenuWidget extends StatelessWidget {
  final Map<String, dynamic> tutorial;
  final VoidCallback onMarkFavorite;
  final VoidCallback onViewProgress;
  final VoidCallback onReset;
  final VoidCallback onClose;

  const TutorialContextMenuWidget({
    Key? key,
    required this.tutorial,
    required this.onMarkFavorite,
    required this.onViewProgress,
    required this.onReset,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isFavorite = tutorial['favorite'] as bool? ?? false;
    final String title = tutorial['title'] as String? ?? '';

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(maxWidth: 80.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppTheme.lightTheme.colorScheme.outline,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.shadowLight,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.outline
                    .withValues(alpha: 0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  GestureDetector(
                    onTap: onClose,
                    child: Container(
                      padding: EdgeInsets.all(1.w),
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

            // Menu Options
            Padding(
              padding: EdgeInsets.all(2.w),
              child: Column(
                children: [
                  _buildMenuOption(
                    icon: isFavorite ? 'favorite' : 'favorite_border',
                    title:
                        isFavorite ? 'Quitar de Favoritos' : 'Marcar Favorito',
                    onTap: onMarkFavorite,
                    color: isFavorite
                        ? AppTheme.primaryEmergency
                        : AppTheme.phoneAction,
                  ),
                  _buildMenuOption(
                    icon: 'analytics',
                    title: 'Ver Progreso',
                    onTap: onViewProgress,
                    color: AppTheme.messageCameraAction,
                  ),
                  _buildMenuOption(
                    icon: 'refresh',
                    title: 'Reiniciar Tutorial',
                    onTap: onReset,
                    color: AppTheme.contactsAction,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuOption({
    required String icon,
    required String title,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.lightTheme.colorScheme.outline
                    .withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomIconWidget(
                    iconName: icon,
                    color: color,
                    size: 6.w,
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Text(
                    title,
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
                CustomIconWidget(
                  iconName: 'arrow_forward_ios',
                  color: AppTheme.textSecondary,
                  size: 4.w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
