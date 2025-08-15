import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CallActionButtonsWidget extends StatelessWidget {
  final VoidCallback onCallPressed;
  final VoidCallback onCancelPressed;
  final bool isCallInProgress;

  const CallActionButtonsWidget({
    super.key,
    required this.onCallPressed,
    required this.onCancelPressed,
    required this.isCallInProgress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main Call Button
        Container(
          width: 70.w,
          height: 12.h,
          child: ElevatedButton(
            onPressed: isCallInProgress ? null : onCallPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.backgroundPrimary,
              foregroundColor: AppTheme.primaryEmergency,
              elevation: 8,
              shadowColor: AppTheme.backgroundPrimary.withValues(alpha: 0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: AppTheme.backgroundPrimary,
                  width: 3,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 2.h),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIconWidget(
                  iconName: 'phone',
                  color: AppTheme.primaryEmergency,
                  size: 28.sp,
                ),
                SizedBox(width: 3.w),
                Text(
                  isCallInProgress ? 'LLAMANDO...' : 'LLAMAR AHORA',
                  style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                    color: AppTheme.primaryEmergency,
                    fontWeight: FontWeight.w900,
                    fontSize: 18.sp,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 4.h),

        // Cancel Button
        Container(
          width: 50.w,
          height: 8.h,
          child: OutlinedButton(
            onPressed: onCancelPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.backgroundPrimary,
              side: BorderSide(
                color: AppTheme.backgroundPrimary,
                width: 2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(vertical: 1.5.h),
            ),
            child: Text(
              'CANCELAR',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.backgroundPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
