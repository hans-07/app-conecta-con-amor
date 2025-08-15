import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import './app_button_widget.dart';

class AppColumnWidget extends StatelessWidget {
  const AppColumnWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> appButtons = [
      {
        'title': 'Teléfono',
        'subtitle': 'Hacer llamadas',
        'icon': 'phone',
        'color': AppTheme.phoneAction,
        'action': () => _handlePhoneAction(context),
        'tutorial': () => _showTutorialOption(context, 'Teléfono'),
      },
      {
        'title': 'WhatsApp',
        'subtitle': 'Mensajes y llamadas',
        'icon': 'chat',
        'color': const Color(0xFF25D366),
        'action': () => _handleWhatsAppAction(context),
        'tutorial': () => _showWhatsAppTutorial(context),
      },
      {
        'title': 'Mensajes',
        'subtitle': 'Enviar mensajes',
        'icon': 'message',
        'color': AppTheme.messageCameraAction,
        'action': () => _handleMessagesAction(context),
        'tutorial': () => _showTutorialOption(context, 'Mensajes'),
      },
      {
        'title': 'Contactos',
        'subtitle': 'Ver contactos',
        'icon': 'contacts',
        'color': AppTheme.contactsAction,
        'action': () => _handleContactsAction(context),
        'tutorial': () => _showTutorialOption(context, 'Contactos'),
      },
      {
        'title': 'Cámara',
        'subtitle': 'Tomar fotos',
        'icon': 'camera_alt',
        'color': AppTheme.messageCameraAction,
        'action': () => _handleCameraAction(context),
        'tutorial': () => _showTutorialOption(context, 'Cámara'),
      },
      {
        'title': 'Linterna',
        'subtitle': 'Encender/apagar luz',
        'icon': 'flashlight_on',
        'color': const Color(0xFFFFB000),
        'action': () => _handleFlashlightAction(context),
        'tutorial': () => _showTutorialOption(context, 'Linterna'),
      },
      {
        'title': 'Calculadora',
        'subtitle': 'Hacer cálculos',
        'icon': 'calculate',
        'color': const Color(0xFF2196F3),
        'action': () => _handleCalculatorAction(context),
        'tutorial': () => _showTutorialOption(context, 'Calculadora'),
      },
      {
        'title': 'Clima',
        'subtitle': 'Ver pronóstico',
        'icon': 'wb_sunny',
        'color': const Color(0xFF4CAF50),
        'action': () => _handleWeatherAction(context),
        'tutorial': () => _showTutorialOption(context, 'Clima'),
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        children: appButtons.map((button) {
          return Container(
            margin: EdgeInsets.only(bottom: 3.h),
            child: AppButtonWidget(
              title: button['title'] as String,
              subtitle: button['subtitle'] as String,
              iconName: button['icon'] as String,
              backgroundColor: button['color'] as Color,
              onTap: button['action'] as VoidCallback?,
              onLongPress: button['tutorial'] as VoidCallback?,
            ),
          );
        }).toList(),
      ),
    );
  }

  void _handlePhoneAction(BuildContext context) {
    HapticFeedback.lightImpact();
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
      ),
    );
  }

  void _handleWhatsAppAction(BuildContext context) {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Abriendo WhatsApp...',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontSize: 16.sp,
          ),
        ),
        backgroundColor: const Color(0xFF25D366),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleMessagesAction(BuildContext context) {
    HapticFeedback.lightImpact();
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
      ),
    );
  }

  void _handleContactsAction(BuildContext context) {
    HapticFeedback.lightImpact();
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
      ),
    );
  }

  void _handleCameraAction(BuildContext context) {
    HapticFeedback.lightImpact();
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
      ),
    );
  }

  void _handleFlashlightAction(BuildContext context) {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Activando linterna...',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontSize: 16.sp,
          ),
        ),
        backgroundColor: const Color(0xFFFFB000),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleCalculatorAction(BuildContext context) {
    HapticFeedback.lightImpact();
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
      ),
    );
  }

  void _handleWeatherAction(BuildContext context) {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Mostrando pronóstico del clima...',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontSize: 16.sp,
          ),
        ),
        backgroundColor: const Color(0xFF4CAF50),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showWhatsAppTutorial(BuildContext context) {
    HapticFeedback.mediumImpact();
    Navigator.pushNamed(context, '/whats-app-tutorial-guide');
  }

  void _showTutorialOption(BuildContext context, String appName) {
    HapticFeedback.mediumImpact();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.lightTheme.colorScheme.surface,
        title: Text(
          'Tutorial de $appName',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          '¿Deseas ver el tutorial para aprender a usar $appName?',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            fontSize: 16.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancelar',
              style: TextStyle(fontSize: 16.sp),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/tutorial-selection-interface');
            },
            child: Text(
              'Ver Tutorial',
              style: TextStyle(fontSize: 16.sp),
            ),
          ),
        ],
      ),
    );
  }
}
