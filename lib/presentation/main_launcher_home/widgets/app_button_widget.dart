import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AppButtonWidget extends StatelessWidget {
  final String title;
  final String iconName;
  final Color backgroundColor;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const AppButtonWidget({
    Key? key,
    required this.title,
    required this.iconName,
    required this.backgroundColor,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress ?? () => _showContextMenu(context),
      child: Container(
        width: 40.w,
        height: 20.h,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.lightTheme.colorScheme.outline,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: iconName,
              color: Colors.white,
              size: 32,
            ),
            SizedBox(height: 2.h),
            Text(
              title,
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showContextMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 3.h),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'play_circle_outline',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 24,
              ),
              title: Text(
                'Aprender a usar $title',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontSize: 14.sp,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/tutorial-selection-interface');
              },
            ),
            SizedBox(height: 2.h),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'launch',
                color: AppTheme.lightTheme.colorScheme.secondary,
                size: 24,
              ),
              title: Text(
                'Abrir $title',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontSize: 14.sp,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                if (onTap != null) onTap!();
              },
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}
