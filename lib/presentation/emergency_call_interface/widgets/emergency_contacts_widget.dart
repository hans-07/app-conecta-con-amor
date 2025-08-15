import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EmergencyContactsWidget extends StatelessWidget {
  final VoidCallback onContactFamily;

  const EmergencyContactsWidget({
    super.key,
    required this.onContactFamily,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> emergencyContacts = [
      {
        "id": 1,
        "name": "María González",
        "relationship": "Hija",
        "phone": "+34 612 345 678",
        "avatar":
            "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      },
      {
        "id": 2,
        "name": "Carlos Rodríguez",
        "relationship": "Hijo",
        "phone": "+34 687 234 567",
        "avatar":
            "https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      },
      {
        "id": 3,
        "name": "Ana López",
        "relationship": "Vecina",
        "phone": "+34 654 987 321",
        "avatar":
            "https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(6.w),
      child: Column(
        children: [
          Text(
            'CONTACTAR FAMILIA',
            style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
              color: AppTheme.backgroundPrimary,
              fontWeight: FontWeight.w900,
              fontSize: 20.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 1.h),
          Text(
            'Después de la emergencia, puede contactar a sus familiares',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.backgroundPrimary.withValues(alpha: 0.9),
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),

          // Emergency Contacts List
          ...emergencyContacts
              .map((contact) => _buildContactCard(contact))
              .toList(),

          SizedBox(height: 4.h),

          // Back to Home Button
          Container(
            width: 70.w,
            height: 8.h,
            child: OutlinedButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                '/main-launcher-home',
                (route) => false,
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.backgroundPrimary,
                side: BorderSide(
                  color: AppTheme.backgroundPrimary,
                  width: 2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: 'home',
                    color: AppTheme.backgroundPrimary,
                    size: 20.sp,
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    'VOLVER AL INICIO',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.backgroundPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
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

  Widget _buildContactCard(Map<String, dynamic> contact) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.backgroundPrimary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.backgroundPrimary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 15.w,
            height: 15.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppTheme.backgroundPrimary,
                width: 2,
              ),
            ),
            child: ClipOval(
              child: CustomImageWidget(
                imageUrl: contact["avatar"] as String,
                width: 15.w,
                height: 15.w,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(width: 4.w),

          // Contact Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact["name"] as String,
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.backgroundPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  contact["relationship"] as String,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.backgroundPrimary.withValues(alpha: 0.8),
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  contact["phone"] as String,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.backgroundPrimary.withValues(alpha: 0.7),
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),

          // Call Button
          Container(
            width: 12.w,
            height: 12.w,
            child: ElevatedButton(
              onPressed: () {
                // Simulate calling contact
                // In real implementation, would use url_launcher to make call
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.backgroundPrimary,
                foregroundColor: AppTheme.phoneAction,
                elevation: 4,
                shape: const CircleBorder(),
                padding: EdgeInsets.zero,
              ),
              child: CustomIconWidget(
                iconName: 'phone',
                color: AppTheme.phoneAction,
                size: 18.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
