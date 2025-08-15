import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class EmergencyHeaderWidget extends StatelessWidget {
  const EmergencyHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
      child: Column(
        children: [
          Text(
            'LLAMADA DE EMERGENCIA',
            style: AppTheme.lightTheme.textTheme.displayMedium?.copyWith(
              color: AppTheme.backgroundPrimary,
              fontWeight: FontWeight.w900,
              fontSize: 24.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 2.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: AppTheme.backgroundPrimary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.backgroundPrimary,
                width: 2,
              ),
            ),
            child: Text(
              '133',
              style: AppTheme.lightTheme.textTheme.displayLarge?.copyWith(
                color: AppTheme.backgroundPrimary,
                fontWeight: FontWeight.w900,
                fontSize: 48.sp,
                letterSpacing: 4,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
