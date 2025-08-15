import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ActiveCallWidget extends StatefulWidget {
  final VoidCallback onEndCall;
  final VoidCallback onToggleSpeaker;
  final VoidCallback onToggleMute;
  final bool isSpeakerOn;
  final bool isMuted;

  const ActiveCallWidget({
    super.key,
    required this.onEndCall,
    required this.onToggleSpeaker,
    required this.onToggleMute,
    required this.isSpeakerOn,
    required this.isMuted,
  });

  @override
  State<ActiveCallWidget> createState() => _ActiveCallWidgetState();
}

class _ActiveCallWidgetState extends State<ActiveCallWidget> {
  int _callDuration = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _callDuration++;
        });
        _startTimer();
      }
    });
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(6.w),
      child: Column(
        children: [
          // Call Status
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: AppTheme.backgroundPrimary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppTheme.backgroundPrimary.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                CustomIconWidget(
                  iconName: 'phone_in_talk',
                  color: AppTheme.backgroundPrimary,
                  size: 32.sp,
                ),
                SizedBox(height: 1.h),
                Text(
                  'LLAMADA ACTIVA',
                  style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                    color: AppTheme.backgroundPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  'Servicios de Emergencia - 133',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.backgroundPrimary.withValues(alpha: 0.9),
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 4.h),

          // Call Timer
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: AppTheme.backgroundPrimary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              _formatDuration(_callDuration),
              style: AppTheme.lightTheme.textTheme.displayMedium?.copyWith(
                color: AppTheme.backgroundPrimary,
                fontWeight: FontWeight.w900,
                fontSize: 36.sp,
                letterSpacing: 2,
              ),
            ),
          ),

          SizedBox(height: 6.h),

          // Call Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Speaker Button
              _buildControlButton(
                icon: widget.isSpeakerOn ? 'volume_up' : 'volume_down',
                label: 'ALTAVOZ',
                isActive: widget.isSpeakerOn,
                onPressed: widget.onToggleSpeaker,
              ),

              // Mute Button
              _buildControlButton(
                icon: widget.isMuted ? 'mic_off' : 'mic',
                label: 'SILENCIO',
                isActive: widget.isMuted,
                onPressed: widget.onToggleMute,
              ),
            ],
          ),

          SizedBox(height: 6.h),

          // End Call Button
          Container(
            width: 60.w,
            height: 10.h,
            child: ElevatedButton(
              onPressed: widget.onEndCall,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.backgroundPrimary,
                foregroundColor: AppTheme.primaryEmergency,
                elevation: 8,
                shadowColor: AppTheme.backgroundPrimary.withValues(alpha: 0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: 'call_end',
                    color: AppTheme.primaryEmergency,
                    size: 24.sp,
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    'COLGAR',
                    style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                      color: AppTheme.primaryEmergency,
                      fontWeight: FontWeight.w900,
                      fontSize: 18.sp,
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

  Widget _buildControlButton({
    required String icon,
    required String label,
    required bool isActive,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        Container(
          width: 15.w,
          height: 15.w,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: isActive
                  ? AppTheme.backgroundPrimary
                  : AppTheme.backgroundPrimary.withValues(alpha: 0.3),
              foregroundColor: isActive
                  ? AppTheme.primaryEmergency
                  : AppTheme.backgroundPrimary,
              elevation: isActive ? 4 : 2,
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
            ),
            child: CustomIconWidget(
              iconName: icon,
              color: isActive
                  ? AppTheme.primaryEmergency
                  : AppTheme.backgroundPrimary,
              size: 20.sp,
            ),
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.backgroundPrimary.withValues(alpha: 0.9),
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
