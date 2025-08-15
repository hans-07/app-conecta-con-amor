import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/active_call_widget.dart';
import './widgets/call_action_buttons_widget.dart';
import './widgets/call_confirmation_modal_widget.dart';
import './widgets/emergency_contacts_widget.dart';
import './widgets/emergency_header_widget.dart';
import './widgets/location_info_widget.dart';

enum CallState {
  initial,
  confirming,
  calling,
  active,
  ended,
}

class EmergencyCallInterface extends StatefulWidget {
  const EmergencyCallInterface({super.key});

  @override
  State<EmergencyCallInterface> createState() => _EmergencyCallInterfaceState();
}

class _EmergencyCallInterfaceState extends State<EmergencyCallInterface> {
  CallState _currentState = CallState.initial;
  String? _currentLocation;
  bool _isLocationEnabled = false;
  bool _isSpeakerOn = false;
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    _initializeLocation();
    _preventScreenLock();
  }

  void _initializeLocation() {
    // Simulate location detection
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLocationEnabled = true;
          _currentLocation = "Calle Mayor 123, Madrid, España";
        });
      }
    });
  }

  void _preventScreenLock() {
    // Keep screen awake during emergency interface
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    // Restore normal screen behavior
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _handleCallPressed() {
    setState(() {
      _currentState = CallState.confirming;
    });

    // Provide haptic feedback for emergency action
    HapticFeedback.heavyImpact();
  }

  void _handleConfirmCall() {
    setState(() {
      _currentState = CallState.calling;
    });

    // Simulate call connection
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _currentState = CallState.active;
          _isSpeakerOn = true; // Auto-enable speaker for emergency calls
        });
      }
    });

    // In real implementation, would use url_launcher or platform channels
    // to make actual emergency call to 133
  }

  void _handleCancelCall() {
    setState(() {
      _currentState = CallState.initial;
    });
  }

  void _handleEndCall() {
    setState(() {
      _currentState = CallState.ended;
    });

    HapticFeedback.mediumImpact();
  }

  void _handleToggleSpeaker() {
    setState(() {
      _isSpeakerOn = !_isSpeakerOn;
    });

    HapticFeedback.lightImpact();
  }

  void _handleToggleMute() {
    setState(() {
      _isMuted = !_isMuted;
    });

    HapticFeedback.lightImpact();
  }

  void _handleContactFamily() {
    // Navigate to family contact functionality
    // In real implementation, would show contact list or make calls
  }

  void _handleBackPressed() {
    if (_currentState == CallState.initial) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/main-launcher-home',
        (route) => false,
      );
    } else if (_currentState == CallState.confirming) {
      _handleCancelCall();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _handleBackPressed();
        return false;
      },
      child: Scaffold(
        backgroundColor: AppTheme.primaryEmergency,
        body: SafeArea(
          child: Stack(
            children: [
              // Main Content
              SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    minHeight: 100.h -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom,
                  ),
                  child: _buildMainContent(),
                ),
              ),

              // Confirmation Modal Overlay
              if (_currentState == CallState.confirming)
                CallConfirmationModalWidget(
                  onConfirm: _handleConfirmCall,
                  onCancel: _handleCancelCall,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    switch (_currentState) {
      case CallState.initial:
      case CallState.confirming:
        return _buildInitialInterface();
      case CallState.calling:
        return _buildCallingInterface();
      case CallState.active:
        return _buildActiveCallInterface();
      case CallState.ended:
        return _buildPostCallInterface();
    }
  }

  Widget _buildInitialInterface() {
    return Column(
      children: [
        SizedBox(height: 4.h),

        // Emergency Header
        const EmergencyHeaderWidget(),

        SizedBox(height: 4.h),

        // Location Information
        LocationInfoWidget(
          currentLocation: _currentLocation,
          isLocationEnabled: _isLocationEnabled,
        ),

        SizedBox(height: 6.h),

        // Call Action Buttons
        CallActionButtonsWidget(
          onCallPressed: _handleCallPressed,
          onCancelPressed: _handleBackPressed,
          isCallInProgress: false,
        ),

        SizedBox(height: 4.h),

        // Emergency Instructions
        Container(
          margin: EdgeInsets.symmetric(horizontal: 6.w),
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppTheme.backgroundPrimary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppTheme.backgroundPrimary.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              CustomIconWidget(
                iconName: 'info',
                color: AppTheme.backgroundPrimary,
                size: 20.sp,
              ),
              SizedBox(height: 1.h),
              Text(
                'Instrucciones de Emergencia',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.backgroundPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 1.h),
              Text(
                '• Mantenga la calma y hable claramente\n• Proporcione su ubicación exacta\n• Describa la emergencia brevemente\n• Siga las instrucciones del operador',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.backgroundPrimary.withValues(alpha: 0.9),
                  fontSize: 12.sp,
                  height: 1.4,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),

        SizedBox(height: 4.h),
      ],
    );
  }

  Widget _buildCallingInterface() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 20.h),

        // Calling Animation
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.backgroundPrimary.withValues(alpha: 0.2),
            border: Border.all(
              color: AppTheme.backgroundPrimary,
              width: 3,
            ),
          ),
          child: Center(
            child: CustomIconWidget(
              iconName: 'phone',
              color: AppTheme.backgroundPrimary,
              size: 48.sp,
            ),
          ),
        ),

        SizedBox(height: 4.h),

        Text(
          'CONECTANDO...',
          style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
            color: AppTheme.backgroundPrimary,
            fontWeight: FontWeight.w900,
            fontSize: 24.sp,
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 2.h),

        Text(
          'Servicios de Emergencia - 133',
          style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
            color: AppTheme.backgroundPrimary.withValues(alpha: 0.9),
            fontSize: 16.sp,
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 8.h),

        // Cancel Button
        Container(
          width: 50.w,
          height: 8.h,
          child: OutlinedButton(
            onPressed: _handleCancelCall,
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
            child: Text(
              'CANCELAR',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.backgroundPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActiveCallInterface() {
    return ActiveCallWidget(
      onEndCall: _handleEndCall,
      onToggleSpeaker: _handleToggleSpeaker,
      onToggleMute: _handleToggleMute,
      isSpeakerOn: _isSpeakerOn,
      isMuted: _isMuted,
    );
  }

  Widget _buildPostCallInterface() {
    return Column(
      children: [
        SizedBox(height: 6.h),

        // Call Ended Status
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 6.w),
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: AppTheme.backgroundPrimary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppTheme.backgroundPrimary,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              CustomIconWidget(
                iconName: 'check_circle',
                color: AppTheme.backgroundPrimary,
                size: 40.sp,
              ),
              SizedBox(height: 2.h),
              Text(
                'LLAMADA FINALIZADA',
                style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                  color: AppTheme.backgroundPrimary,
                  fontWeight: FontWeight.w900,
                  fontSize: 20.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 1.h),
              Text(
                'Su llamada de emergencia ha sido registrada',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.backgroundPrimary.withValues(alpha: 0.9),
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        SizedBox(height: 6.h),

        // Emergency Contacts Section
        EmergencyContactsWidget(
          onContactFamily: _handleContactFamily,
        ),
      ],
    );
  }
}
