import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class LocationInfoWidget extends StatelessWidget {
  final String? currentLocation;
  final bool isLocationEnabled;

  const LocationInfoWidget({
    super.key,
    this.currentLocation,
    required this.isLocationEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 6.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.backgroundPrimary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.backgroundPrimary.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIconWidget(
                iconName: 'location_on',
                color: AppTheme.backgroundPrimary,
                size: 20.sp,
              ),
              SizedBox(width: 2.w),
              Text(
                'Ubicación Actual',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.backgroundPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            isLocationEnabled && currentLocation != null
                ? currentLocation!
                : 'Ubicación no disponible',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.backgroundPrimary.withValues(alpha: 0.9),
              fontSize: 12.sp,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (isLocationEnabled && currentLocation != null) ...[
            SizedBox(height: 1.h),
            Text(
              'Se compartirá durante la llamada',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.backgroundPrimary.withValues(alpha: 0.8),
                fontSize: 10.sp,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
