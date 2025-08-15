import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import './enhanced_app_button_widget.dart';

class EnhancedAppGridWidget extends StatelessWidget {
  const EnhancedAppGridWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> appButtons = [
      {
        'title': 'Teléfono',
        'subtitle': 'Hacer llamadas',
        'icon': 'phone',
        'color': AppTheme.phoneAction,
        'action': () => _handlePhoneAction(context),
      },
      {
        'title': 'WhatsApp',
        'subtitle': 'Mensajes y llamadas',
        'icon': 'chat',
        'color': const Color(
            0xFF25D366), // WhatsApp green 'action': () => _handleWhatsAppAction(context),
      },
      {
        'title': 'Mensajes',
        'subtitle': 'Enviar mensajes',
        'icon': 'message',
        'color': AppTheme.messageCameraAction,
        'action': () => _handleMessagesAction(context),
      },
      {
        'title': 'Contactos',
        'subtitle': 'Ver contactos',
        'icon': 'contacts',
        'color': AppTheme.contactsAction,
        'action': () => _handleContactsAction(context),
      },
      {
        'title': 'Cámara',
        'subtitle': 'Tomar fotos',
        'icon': 'camera_alt',
        'color': AppTheme.messageCameraAction,
        'action': () => _handleCameraAction(context),
      },
      {
        'title': 'Linterna',
        'subtitle': 'Iluminar',
        'icon': 'flashlight_on',
        'color': const Color(
            0xFFFF9800), // Orange 'action': () => _handleFlashlightAction(context),
      },
      {
        'title': 'Calculadora',
        'subtitle': 'Hacer cálculos',
        'icon': 'calculate',
        'color': const Color(
            0xFF2196F3), // Blue 'action': () => _handleCalculatorAction(context),
      },
      {
        'title': 'Clima',
        'subtitle': 'Ver pronóstico',
        'icon': 'wb_sunny',
        'color': const Color(
            0xFF4CAF50), // Green 'action': () => _handleWeatherAction(context),
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        children: [
          // Title section
          Container(
            margin: EdgeInsets.only(bottom: 3.h),
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: AppTheme.lightTheme.colorScheme.outline,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'apps',
                  color: AppTheme.lightTheme.colorScheme.primary,
                  size: 8.w,
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Aplicaciones Útiles',
                        style:
                            AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.lightTheme.colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        'Toca una aplicación para usarla',
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          fontSize: 16.sp,
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // App buttons in single column layout as requested
          Column(
            children: appButtons.map((button) {
              return Container(
                margin: EdgeInsets.only(bottom: 3.h),
                child: EnhancedAppButtonWidget(
                  title: button['title'] as String,
                  subtitle: button['subtitle'] as String,
                  iconName: button['icon'] as String,
                  backgroundColor: button['color'] as Color,
                  onTap: button['action'] as VoidCallback?,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _handlePhoneAction(BuildContext context) {
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Abriendo aplicación de teléfono...',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontSize: 16.sp,
          ),
        ),
        backgroundColor: AppTheme.phoneAction,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  void _handleWhatsAppAction(BuildContext context) {
    HapticFeedback.mediumImpact();

    // Show options: Open WhatsApp or Learn to use WhatsApp
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.all(6.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12.w,
              height: 0.8.h,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.outline,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'WhatsApp',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 3.h),

            // Learn to use WhatsApp option
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF25D366).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const CustomIconWidget(
                  iconName: 'school',
                  color: Color(0xFF25D366),
                  size: 24,
                ),
              ),
              title: Text(
                'Aprender a usar WhatsApp',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                'Tutorial paso a paso',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.whatsAppTutorialGuide);
              },
            ),

            SizedBox(height: 2.h),

            // Open WhatsApp option
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF25D366).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const CustomIconWidget(
                  iconName: 'launch',
                  color: Color(0xFF25D366),
                  size: 24,
                ),
              ),
              title: Text(
                'Abrir WhatsApp',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                'Ir a la aplicación',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Abriendo WhatsApp...',
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                    backgroundColor: const Color(0xFF25D366),
                  ),
                );
              },
            ),

            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }

  void _handleMessagesAction(BuildContext context) {
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Abriendo aplicación de mensajes...',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontSize: 16.sp,
          ),
        ),
        backgroundColor: AppTheme.messageCameraAction,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  void _handleContactsAction(BuildContext context) {
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Abriendo aplicación de contactos...',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontSize: 16.sp,
          ),
        ),
        backgroundColor: AppTheme.contactsAction,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  void _handleCameraAction(BuildContext context) {
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Abriendo aplicación de cámara...',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontSize: 16.sp,
          ),
        ),
        backgroundColor: AppTheme.messageCameraAction,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  void _handleFlashlightAction(BuildContext context) {
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Activando linterna...',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontSize: 16.sp,
          ),
        ),
        backgroundColor: const Color(0xFFFF9800),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  void _handleCalculatorAction(BuildContext context) {
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Abriendo calculadora...',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontSize: 16.sp,
          ),
        ),
        backgroundColor: const Color(0xFF2196F3),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  void _handleWeatherAction(BuildContext context) {
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Consultando el clima...',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontSize: 16.sp,
          ),
        ),
        backgroundColor: const Color(0xFF4CAF50),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
