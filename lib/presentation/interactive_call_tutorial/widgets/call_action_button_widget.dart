import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CallActionButtonWidget extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onPressed;
  final String phoneNumber;

  const CallActionButtonWidget({
    Key? key,
    required this.isEnabled,
    required this.onPressed,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      child: Column(
        children: [
          GestureDetector(
            onTap: isEnabled
                ? () {
                    HapticFeedback.mediumImpact();
                    onPressed();
                  }
                : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                color: isEnabled
                    ? AppTheme.phoneAction
                    : AppTheme.textSecondary.withValues(alpha: 0.3),
                shape: BoxShape.circle,
                boxShadow: isEnabled
                    ? [
                        BoxShadow(
                          color: AppTheme.phoneAction.withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: 'call',
                  color: AppTheme.backgroundPrimary,
                  size: 32,
                ),
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            'Llamar',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: isEnabled ? AppTheme.phoneAction : AppTheme.textSecondary,
            ),
          ),
          if (phoneNumber.isNotEmpty) ...[
            SizedBox(height: 1.h),
            Text(
              phoneNumber,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
