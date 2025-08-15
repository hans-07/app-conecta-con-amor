import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class DialerKeypadWidget extends StatelessWidget {
  final String phoneNumber;
  final Function(String) onNumberPressed;
  final VoidCallback onDeletePressed;

  const DialerKeypadWidget({
    Key? key,
    required this.phoneNumber,
    required this.onNumberPressed,
    required this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        children: [
          // Phone number display
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
            margin: EdgeInsets.only(bottom: 3.h),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.borderSubtle,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    phoneNumber.isEmpty ? 'Ingresa un número' : phoneNumber,
                    style:
                        AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: phoneNumber.isEmpty
                          ? AppTheme.textSecondary
                          : AppTheme.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                if (phoneNumber.isNotEmpty)
                  GestureDetector(
                    onTap: onDeletePressed,
                    child: Container(
                      width: 12.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                        color: AppTheme.textSecondary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: CustomIconWidget(
                          iconName: 'backspace',
                          color: AppTheme.textSecondary,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Keypad
          _buildKeypadGrid(),
        ],
      ),
    );
  }

  Widget _buildKeypadGrid() {
    final List<List<String>> keypadLayout = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['*', '0', '#'],
    ];

    return Column(
      children: keypadLayout.map((row) {
        return Padding(
          padding: EdgeInsets.only(bottom: 2.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: row.map((number) {
              return _buildKeypadButton(number);
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildKeypadButton(String number) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onNumberPressed(number);
      },
      child: Container(
        width: 20.w,
        height: 10.h,
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.borderSubtle,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.shadowLight,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            number,
            style: AppTheme.lightTheme.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
