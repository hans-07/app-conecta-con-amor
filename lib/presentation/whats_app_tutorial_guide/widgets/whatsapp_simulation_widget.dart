import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class WhatsAppSimulationWidget extends StatefulWidget {
  final Map<String, dynamic> stepData;
  final VoidCallback onComplete;

  const WhatsAppSimulationWidget({
    Key? key,
    required this.stepData,
    required this.onComplete,
  }) : super(key: key);

  @override
  State<WhatsAppSimulationWidget> createState() =>
      _WhatsAppSimulationWidgetState();
}

class _WhatsAppSimulationWidgetState extends State<WhatsAppSimulationWidget>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  final TextEditingController _messageController = TextEditingController();
  bool _isTaskComplete = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE5DDD5), // WhatsApp chat background
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          _buildWhatsAppHeader(),
          Expanded(
            child: _buildSimulationContent(),
          ),
          _buildWhatsAppInputBar(),
        ],
      ),
    );
  }

  Widget _buildWhatsAppHeader() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: const BoxDecoration(
        color: Color(0xFF075E54),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 6.w,
            child: Icon(
              Icons.person,
              color: const Color(0xFF075E54),
              size: 6.w,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Familia',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'en línea',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    fontSize: 12.sp,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.videocam,
              color: Colors.white,
              size: 6.w,
            ),
          ),
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.call,
              color: Colors.white,
              size: 6.w,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimulationContent() {
    final String icon = widget.stepData['icon'] as String;
    final String title = widget.stepData['title'] as String;

    return Padding(
      padding: EdgeInsets.all(4.w),
      child: Column(
        children: [
          // Example messages
          _buildExampleMessage("¡Hola! ¿Cómo estás?", false),
          SizedBox(height: 2.h),
          _buildExampleMessage("¡Muy bien! ¿Y tú?", true),
          SizedBox(height: 2.h),

          // Instruction overlay
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: const Color(0xFF25D366).withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              children: [
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _pulseAnimation.value,
                      child: Container(
                        width: 15.w,
                        height: 15.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Icon(
                          _getIconData(icon),
                          color: const Color(0xFF25D366),
                          size: 8.w,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 2.h),
                Text(
                  _getInstructionText(title),
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 1.h),
                if (!_isTaskComplete)
                  ElevatedButton(
                    onPressed: _completeTask,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF25D366),
                      minimumSize: Size(double.infinity, 5.h),
                    ),
                    child: Text(
                      'Realizar Acción',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                else
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.white,
                          size: 5.w,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          '¡Completado!',
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
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

  Widget _buildExampleMessage(String text, bool isSentByUser) {
    return Align(
      alignment: isSentByUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: 75.w),
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: isSentByUser ? const Color(0xFFDCF8C6) : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          text,
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildWhatsAppInputBar() {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: 'Escribe un mensaje...',
                  border: InputBorder.none,
                ),
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
          SizedBox(width: 2.w),
          CircleAvatar(
            backgroundColor: const Color(0xFF25D366),
            radius: 6.w,
            child: IconButton(
              onPressed: null,
              icon: Icon(
                Icons.send,
                color: Colors.white,
                size: 5.w,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'person':
        return Icons.person;
      case 'keyboard':
        return Icons.keyboard;
      case 'send':
        return Icons.send;
      case 'photo_camera':
        return Icons.photo_camera;
      case 'mic':
        return Icons.mic;
      case 'phone':
        return Icons.phone;
      case 'videocam':
        return Icons.videocam;
      default:
        return Icons.touch_app;
    }
  }

  String _getInstructionText(String title) {
    switch (title) {
      case 'Seleccionar un Contacto':
        return 'Toca un contacto de la lista para abrir el chat';
      case 'Escribir un Mensaje':
        return 'Toca el campo de texto y escribe tu mensaje';
      case 'Enviar el Mensaje':
        return 'Toca el botón verde para enviar';
      case 'Enviar Fotos':
        return 'Toca el icono de cámara para adjuntar fotos';
      case 'Mensajes de Voz':
        return 'Mantén presionado el micrófono para grabar';
      case 'Hacer Llamadas':
        return 'Toca el icono de teléfono para llamar';
      case 'Videollamadas':
        return 'Toca el icono de video para videollamar';
      default:
        return 'Sigue las instrucciones en pantalla';
    }
  }

  void _completeTask() {
    HapticFeedback.lightImpact();
    setState(() {
      _isTaskComplete = true;
    });

    // Auto complete after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        widget.onComplete();
      }
    });
  }
}
