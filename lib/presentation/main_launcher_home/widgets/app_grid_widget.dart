import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import './app_button_widget.dart';

class AppGridWidget extends StatelessWidget {
  const AppGridWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> appButtons = [
      {
        'title': 'Teléfono',
        'icon': 'phone',
        'color': AppTheme.phoneAction,
        'action': () => _handlePhoneAction(context),
      },
      {
        'title': 'Mensajes',
        'icon': 'message',
        'color': AppTheme.messageCameraAction,
        'action': () => _handleMessagesAction(context),
      },
      {
        'title': 'Contactos',
        'icon': 'contacts',
        'color': AppTheme.contactsAction,
        'action': () => _handleContactsAction(context),
      },
      {
        'title': 'Cámara',
        'icon': 'camera_alt',
        'color': AppTheme.messageCameraAction,
        'action': () => _handleCameraAction(context),
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4.w,
          mainAxisSpacing: 3.h,
          childAspectRatio: 0.8,
        ),
        itemCount: appButtons.length,
        itemBuilder: (context, index) {
          final button = appButtons[index];
          return AppButtonWidget(
            title: button['title'] as String,
            iconName: button['icon'] as String,
            backgroundColor: button['color'] as Color,
            onTap: button['action'] as VoidCallback?,
          );
        },
      ),
    );
  }

  void _handlePhoneAction(BuildContext context) {
    // Launch phone app or show phone interface
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Abriendo aplicación de teléfono...',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: Colors.white,
          ),
        ),
        backgroundColor: AppTheme.phoneAction,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleMessagesAction(BuildContext context) {
    // Launch messages app
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Abriendo aplicación de mensajes...',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: Colors.white,
          ),
        ),
        backgroundColor: AppTheme.messageCameraAction,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleContactsAction(BuildContext context) {
    // Launch contacts app
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Abriendo aplicación de contactos...',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: Colors.white,
          ),
        ),
        backgroundColor: AppTheme.contactsAction,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleCameraAction(BuildContext context) {
    // Launch camera app
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Abriendo aplicación de cámara...',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: Colors.white,
          ),
        ),
        backgroundColor: AppTheme.messageCameraAction,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
