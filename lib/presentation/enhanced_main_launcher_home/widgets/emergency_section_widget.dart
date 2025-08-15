import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EmergencySectionWidget extends StatelessWidget {
  const EmergencySectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.emergencyBackground,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: AppTheme.primaryEmergency,
          width: 2.0,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'warning',
                color: AppTheme.primaryEmergency,
                size: 8.w,
              ),
              SizedBox(width: 3.w),
              Text(
                'EMERGENCIA',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primaryEmergency,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          SizedBox(
            width: double.infinity,
            height: 8.h,
            child: ElevatedButton(
              onPressed: () => _handleEmergencyCall(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryEmergency,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 4.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: 'phone',
                    color: Colors.white,
                    size: 8.w,
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    'Llamar 133',
                    style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Llamada de emergencia',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              fontSize: 14.sp,
              color: AppTheme.primaryEmergency,
            ),
          ),
        ],
      ),
    );
  }

  void _handleEmergencyCall(BuildContext context) {
    HapticFeedback.heavyImpact();
    Navigator.pushNamed(context, '/emergency-call-interface');
  }
}
