import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EmergencySectionWidget extends StatelessWidget {
  final VoidCallback? onEmergencyPressed;

  const EmergencySectionWidget({
    Key? key,
    this.onEmergencyPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.emergencyBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            'EMERGENCIA',
            style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
              color: AppTheme.primaryEmergency,
              fontWeight: FontWeight.w800,
              fontSize: 16.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 2.h),
          SizedBox(
            width: double.infinity,
            height: 8.h,
            child: ElevatedButton(
              onPressed:
                  onEmergencyPressed ?? () => _handleEmergencyCall(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryEmergency,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 3,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: 'phone',
                    color: Colors.white,
                    size: 24,
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    'LLAMAR 133',
                    style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleEmergencyCall(BuildContext context) {
    // Navigate to emergency call interface
    Navigator.pushNamed(context, '/emergency-call-interface');
  }
}
