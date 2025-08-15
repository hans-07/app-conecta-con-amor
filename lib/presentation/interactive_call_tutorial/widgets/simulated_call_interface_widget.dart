import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SimulatedCallInterfaceWidget extends StatefulWidget {
  final String contactName;
  final String phoneNumber;
  final VoidCallback onEndCall;
  final VoidCallback onNextStep;

  const SimulatedCallInterfaceWidget({
    Key? key,
    required this.contactName,
    required this.phoneNumber,
    required this.onEndCall,
    required this.onNextStep,
  }) : super(key: key);

  @override
  State<SimulatedCallInterfaceWidget> createState() =>
      _SimulatedCallInterfaceWidgetState();
}

class _SimulatedCallInterfaceWidgetState
    extends State<SimulatedCallInterfaceWidget> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  bool _isMuted = false;
  bool _isSpeakerOn = false;
  int _callDuration = 0;
  late AnimationController _callDurationController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
    _pulseController.repeat(reverse: true);

    _callDurationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _startCallTimer();
  }

  void _startCallTimer() {
    _callDurationController.repeat();
    _callDurationController.addListener(() {
      if (_callDurationController.isCompleted) {
        setState(() {
          _callDuration++;
        });
      }
    });
  }

  String _formatCallDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _callDurationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppTheme.phoneAction.withValues(alpha: 0.1),
            AppTheme.lightTheme.colorScheme.surface,
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 4.h),
            // Call status
            Text(
              'Llamando...',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                color: AppTheme.phoneAction,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              _formatCallDuration(_callDuration),
              style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            SizedBox(height: 6.h),
            // Contact avatar
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _pulseAnimation.value,
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: AppTheme.phoneAction.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.phoneAction,
                        width: 3,
                      ),
                    ),
                    child: Center(
                      child: CustomIconWidget(
                        iconName: 'person',
                        color: AppTheme.phoneAction,
                        size: 64,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 4.h),
            // Contact name
            Text(
              widget.contactName,
              style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.h),
            Text(
              widget.phoneNumber,
              style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            const Spacer(),
            // Call controls
            _buildCallControls(),
            SizedBox(height: 4.h),
            // Tutorial guidance
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.phoneAction.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.phoneAction.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    '¡Excelente! Has iniciado una llamada simulada.',
                    style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.phoneAction,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'Prueba los controles de la llamada y luego toca "Siguiente" para continuar.',
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget _buildCallControls() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        children: [
          // Top row controls
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildControlButton(
                icon: _isMuted ? 'mic_off' : 'mic',
                label: _isMuted ? 'Activar' : 'Silenciar',
                isActive: _isMuted,
                onTap: () {
                  HapticFeedback.lightImpact();
                  setState(() {
                    _isMuted = !_isMuted;
                  });
                },
              ),
              _buildControlButton(
                icon: 'dialpad',
                label: 'Teclado',
                isActive: false,
                onTap: () {
                  HapticFeedback.lightImpact();
                },
              ),
              _buildControlButton(
                icon: _isSpeakerOn ? 'volume_up' : 'volume_down',
                label: _isSpeakerOn ? 'Altavoz' : 'Auricular',
                isActive: _isSpeakerOn,
                onTap: () {
                  HapticFeedback.lightImpact();
                  setState(() {
                    _isSpeakerOn = !_isSpeakerOn;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 4.h),
          // End call button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  widget.onEndCall();
                },
                child: Container(
                  width: 18.w,
                  height: 18.w,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryEmergency,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryEmergency.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: CustomIconWidget(
                      iconName: 'call_end',
                      color: AppTheme.backgroundPrimary,
                      size: 28,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  widget.onNextStep();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: AppTheme.phoneAction,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.phoneAction.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    'Siguiente',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.backgroundPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required String icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 15.w,
            height: 15.w,
            decoration: BoxDecoration(
              color: isActive
                  ? AppTheme.phoneAction
                  : AppTheme.lightTheme.colorScheme.surface,
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive ? AppTheme.phoneAction : AppTheme.borderSubtle,
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
              child: CustomIconWidget(
                iconName: icon,
                color: isActive
                    ? AppTheme.backgroundPrimary
                    : AppTheme.textPrimary,
                size: 24,
              ),
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            label,
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
