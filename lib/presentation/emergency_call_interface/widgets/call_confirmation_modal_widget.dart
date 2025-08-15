import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CallConfirmationModalWidget extends StatefulWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const CallConfirmationModalWidget({
    super.key,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  State<CallConfirmationModalWidget> createState() =>
      _CallConfirmationModalWidgetState();
}

class _CallConfirmationModalWidgetState
    extends State<CallConfirmationModalWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  int _countdown = 3;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );

    _animationController.forward();
    _startCountdown();
  }

  void _startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _countdown > 1) {
        setState(() {
          _countdown--;
        });
        _startCountdown();
      } else if (mounted && _countdown == 1) {
        widget.onConfirm();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppTheme.textPrimary.withValues(alpha: 0.8),
        child: Center(
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              width: 80.w,
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: AppTheme.backgroundPrimary,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.textPrimary.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomIconWidget(
                    iconName: 'warning',
                    color: AppTheme.primaryEmergency,
                    size: 40.sp,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'CONFIRMACIÓN',
                    style:
                        AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                      color: AppTheme.primaryEmergency,
                      fontWeight: FontWeight.w900,
                      fontSize: 20.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '¿Está seguro de llamar a emergencias?',
                    style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textPrimary,
                      fontSize: 16.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 3.h),
                  Container(
                    width: 20.w,
                    height: 20.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.primaryEmergency,
                      border: Border.all(
                        color: AppTheme.primaryEmergency.withValues(alpha: 0.3),
                        width: 4,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '$_countdown',
                        style: AppTheme.lightTheme.textTheme.displayMedium
                            ?.copyWith(
                          color: AppTheme.backgroundPrimary,
                          fontWeight: FontWeight.w900,
                          fontSize: 32.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    'Llamando automáticamente en $_countdown segundos',
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                      fontSize: 12.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 3.h),
                  SizedBox(
                    width: double.infinity,
                    height: 8.h,
                    child: ElevatedButton(
                      onPressed: widget.onCancel,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.textSecondary,
                        foregroundColor: AppTheme.backgroundPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'CANCELAR',
                        style:
                            AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                          color: AppTheme.backgroundPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
