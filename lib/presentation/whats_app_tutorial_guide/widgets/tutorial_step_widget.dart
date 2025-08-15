import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TutorialStepWidget extends StatelessWidget {
  final Map<String, dynamic> stepData;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onStartSimulation;
  final bool isFirstStep;
  final bool isLastStep;

  const TutorialStepWidget({
    Key? key,
    required this.stepData,
    required this.onNext,
    required this.onPrevious,
    required this.onStartSimulation,
    required this.isFirstStep,
    required this.isLastStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6.w),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 25.w,
                  height: 25.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF075E54).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Center(
                    child: CustomIconWidget(
                      iconName: stepData['icon'] as String,
                      color: const Color(0xFF075E54),
                      size: 12.w,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  stepData['title'] as String,
                  style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF075E54),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 2.h),
                Text(
                  stepData['description'] as String,
                  style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                    fontSize: 18.sp,
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4.h),
                if (stepData['simulation'] as bool)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF25D366).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: const Color(0xFF25D366),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.play_circle_outline,
                              color: const Color(0xFF25D366),
                              size: 6.w,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              'Práctica Interactiva Disponible',
                              style: AppTheme.lightTheme.textTheme.titleMedium
                                  ?.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF25D366),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          'Toca "Practicar" para simular esta acción en WhatsApp.',
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            fontSize: 14.sp,
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: onStartSimulation,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF25D366),
                              foregroundColor: Colors.white,
                              minimumSize: Size(double.infinity, 6.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.touch_app,
                                  size: 5.w,
                                ),
                                SizedBox(width: 2.w),
                                Text(
                                  'Practicar Ahora',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
