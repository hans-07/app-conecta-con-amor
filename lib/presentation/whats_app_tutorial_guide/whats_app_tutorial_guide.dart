import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import './widgets/tutorial_header_widget.dart';
import './widgets/tutorial_progress_widget.dart';
import './widgets/tutorial_step_widget.dart';
import './widgets/whatsapp_simulation_widget.dart';

class WhatsAppTutorialGuide extends StatefulWidget {
  const WhatsAppTutorialGuide({Key? key}) : super(key: key);

  @override
  State<WhatsAppTutorialGuide> createState() => _WhatsAppTutorialGuideState();
}

class _WhatsAppTutorialGuideState extends State<WhatsAppTutorialGuide> {
  int _currentStep = 0;
  bool _isSimulationMode = false;

  final List<Map<String, dynamic>> _tutorialSteps = [
    {
      'title': 'Bienvenido a WhatsApp',
      'description':
          'WhatsApp te permite enviar mensajes, hacer llamadas y compartir fotos con familiares y amigos.',
      'icon': 'chat',
      'simulation': false,
    },
    {
      'title': 'Abrir WhatsApp',
      'description':
          'Toca el icono verde de WhatsApp en tu pantalla principal para abrir la aplicación.',
      'icon': 'touch_app',
      'simulation': false,
    },
    {
      'title': 'Seleccionar un Contacto',
      'description':
          'En la lista de chats, toca el nombre de la persona con quien quieres conversar.',
      'icon': 'person',
      'simulation': true,
    },
    {
      'title': 'Escribir un Mensaje',
      'description':
          'Toca la barra inferior donde dice "Escribe un mensaje..." y utiliza el teclado.',
      'icon': 'keyboard',
      'simulation': true,
    },
    {
      'title': 'Enviar el Mensaje',
      'description':
          'Toca el botón verde con la flecha para enviar tu mensaje.',
      'icon': 'send',
      'simulation': true,
    },
    {
      'title': 'Enviar Fotos',
      'description':
          'Toca el icono de la cámara para tomar una foto o seleccionar una de tu galería.',
      'icon': 'photo_camera',
      'simulation': true,
    },
    {
      'title': 'Mensajes de Voz',
      'description':
          'Mantén presionado el icono del micrófono para grabar un mensaje de voz.',
      'icon': 'mic',
      'simulation': true,
    },
    {
      'title': 'Hacer Llamadas',
      'description':
          'Toca el icono del teléfono en la parte superior del chat para hacer una llamada.',
      'icon': 'phone',
      'simulation': true,
    },
    {
      'title': 'Videollamadas',
      'description':
          'Toca el icono de la cámara de video para hacer una videollamada.',
      'icon': 'videocam',
      'simulation': true,
    },
    {
      'title': 'Consejos de Seguridad',
      'description':
          'Nunca compartas información personal como contraseñas o números de tarjetas con extraños.',
      'icon': 'security',
      'simulation': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentStepData = _tutorialSteps[_currentStep];

    return Scaffold(
      backgroundColor: const Color(0xFF075E54), // WhatsApp green background
      appBar: AppBar(
        backgroundColor: const Color(0xFF075E54),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          iconSize: 8.w,
        ),
        title: const TutorialHeaderWidget(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TutorialProgressWidget(
              currentStep: _currentStep,
              totalSteps: _tutorialSteps.length,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: _isSimulationMode
                    ? WhatsAppSimulationWidget(
                        stepData: currentStepData,
                        onComplete: _completeCurrentStep,
                      )
                    : TutorialStepWidget(
                        stepData: currentStepData,
                        onNext: _nextStep,
                        onPrevious: _previousStep,
                        onStartSimulation: _startSimulation,
                        isFirstStep: _currentStep == 0,
                        isLastStep: _currentStep == _tutorialSteps.length - 1,
                      ),
              ),
            ),
            if (!_isSimulationMode) _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: ElevatedButton(
                onPressed: _previousStep,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF075E54),
                  minimumSize: Size(double.infinity, 7.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: const BorderSide(color: Color(0xFF075E54), width: 2),
                  ),
                ),
                child: Text(
                  'Anterior',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          if (_currentStep > 0) SizedBox(width: 4.w),
          Expanded(
            child: ElevatedButton(
              onPressed: _currentStep < _tutorialSteps.length - 1
                  ? _nextStep
                  : _completeTutorial,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF25D366),
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 7.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: Text(
                _currentStep < _tutorialSteps.length - 1
                    ? 'Siguiente'
                    : 'Completar',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _nextStep() {
    if (_currentStep < _tutorialSteps.length - 1) {
      setState(() {
        _currentStep++;
        _isSimulationMode = false;
      });
      HapticFeedback.lightImpact();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
        _isSimulationMode = false;
      });
      HapticFeedback.lightImpact();
    }
  }

  void _startSimulation() {
    setState(() {
      _isSimulationMode = true;
    });
    HapticFeedback.mediumImpact();
  }

  void _completeCurrentStep() {
    setState(() {
      _isSimulationMode = false;
    });

    // Show completion feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '¡Paso completado exitosamente!',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontSize: 16.sp,
          ),
        ),
        backgroundColor: const Color(0xFF25D366),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );

    // Auto advance to next step
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        _nextStep();
      }
    });
  }

  void _completeTutorial() {
    HapticFeedback.heavyImpact();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                color: const Color(0xFF25D366),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 10.w,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              '¡Tutorial Completado!',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF075E54),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        content: Text(
          'Has completado exitosamente el tutorial de WhatsApp. ¡Ahora ya sabes cómo usar WhatsApp como un experto!',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            fontSize: 16.sp,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Return to main screen
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF25D366),
              foregroundColor: Colors.white,
              minimumSize: Size(double.infinity, 6.h),
            ),
            child: Text(
              'Regresar al Inicio',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
