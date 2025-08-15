import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class TutorialHeaderWidget extends StatelessWidget {
  const TutorialHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                color: const Color(0xFF25D366),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Icon(
                Icons.chat,
                color: Colors.white,
                size: 5.w,
              ),
            ),
            SizedBox(width: 3.w),
            Text(
              'Tutorial WhatsApp',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 0.5.h),
        Text(
          'Aprende paso a paso',
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            fontSize: 12.sp,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}
