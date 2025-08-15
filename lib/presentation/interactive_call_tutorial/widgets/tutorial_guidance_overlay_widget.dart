import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TutorialGuidanceOverlayWidget extends StatefulWidget {
  final String message;
  final String? highlightedElement;
  final VoidCallback? onNext;
  final VoidCallback? onSkip;
  final bool showPulse;

  const TutorialGuidanceOverlayWidget({
    Key? key,
    required this.message,
    this.highlightedElement,
    this.onNext,
    this.onSkip,
    this.showPulse = false,
  }) : super(key: key);

  @override
  State<TutorialGuidanceOverlayWidget> createState() =>
      _TutorialGuidanceOverlayWidgetState();
}

class _TutorialGuidanceOverlayWidgetState
    extends State<TutorialGuidanceOverlayWidget> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    if (widget.showPulse) {
      _pulseController.repeat(reverse: true);
    }

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOut,
    ));

    _slideController.forward();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Semi-transparent overlay
        Container(
          width: double.infinity,
          height: double.infinity,
          color: AppTheme.textPrimary.withValues(alpha: 0.7),
        ),
        // Guidance message
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SlideTransition(
            position: _slideAnimation,
            child: Container(
              margin: EdgeInsets.all(4.w),
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.shadowLight,
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Guidance icon
                  Container(
                    width: 16.w,
                    height: 16.w,
                    decoration: BoxDecoration(
                      color: AppTheme.phoneAction.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: CustomIconWidget(
                        iconName: 'lightbulb',
                        color: AppTheme.phoneAction,
                        size: 32,
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  // Message
                  Text(
                    widget.message,
                    style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textPrimary,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4.h),
                  // Action buttons
                  Row(
                    children: [
                      if (widget.onSkip != null) ...[
                        Expanded(
                          child: GestureDetector(
                            onTap: widget.onSkip,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 2.h),
                              decoration: BoxDecoration(
                                color: AppTheme.textSecondary
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: AppTheme.borderSubtle,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Saltar',
                                  style: AppTheme
                                      .lightTheme.textTheme.titleMedium
                                      ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 4.w),
                      ],
                      if (widget.onNext != null)
                        Expanded(
                          child: AnimatedBuilder(
                            animation: _pulseAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: widget.showPulse
                                    ? _pulseAnimation.value
                                    : 1.0,
                                child: GestureDetector(
                                  onTap: widget.onNext,
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.h),
                                    decoration: BoxDecoration(
                                      color: AppTheme.phoneAction,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppTheme.phoneAction
                                              .withValues(alpha: 0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Continuar',
                                        style: AppTheme
                                            .lightTheme.textTheme.titleMedium
                                            ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.backgroundPrimary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
