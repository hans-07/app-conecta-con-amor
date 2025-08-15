import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import './widgets/call_action_button_widget.dart';
import './widgets/dialer_keypad_widget.dart';
import './widgets/simulated_call_interface_widget.dart';
import './widgets/tutorial_completion_widget.dart';
import './widgets/tutorial_guidance_overlay_widget.dart';
import './widgets/tutorial_header_widget.dart';
import './widgets/tutorial_progress_widget.dart';

enum TutorialStep {
  introduction,
  dialerExplanation,
  numberEntry,
  callInitiation,
  callInterface,
  callControls,
  completion,
}

class InteractiveCallTutorial extends StatefulWidget {
  const InteractiveCallTutorial({Key? key}) : super(key: key);

  @override
  State<InteractiveCallTutorial> createState() =>
      _InteractiveCallTutorialState();
}

class _InteractiveCallTutorialState extends State<InteractiveCallTutorial> {
  TutorialStep _currentStep = TutorialStep.introduction;
  String _phoneNumber = '';
  bool _showGuidanceOverlay = true;
  bool _hasInteractedWithKeypad = false;
  bool _hasInitiatedCall = false;

  // Mock tutorial data
  final List<Map<String, dynamic>> _tutorialSteps = [
    {
      "step": TutorialStep.introduction,
      "title": "Bienvenido al Tutorial de Llamadas",
      "description":
          "Aprenderás a hacer llamadas telefónicas paso a paso de manera segura y práctica.",
      "guidance":
          "Este tutorial te enseñará cómo usar el teléfono sin hacer llamadas reales. ¡Empecemos!",
    },
    {
      "step": TutorialStep.dialerExplanation,
      "title": "Conoce el Teclado",
      "description":
          "El teclado telefónico tiene números del 0 al 9, además de * y #.",
      "guidance":
          "Observa el teclado. Cada botón es grande y fácil de tocar. Los números aparecerán arriba cuando los presiones.",
    },
    {
      "step": TutorialStep.numberEntry,
      "title": "Marca un Número",
      "description":
          "Toca los números en el teclado para formar el número telefónico que deseas llamar.",
      "guidance":
          "Intenta marcar el número 123456789. Toca cada número en el teclado.",
    },
    {
      "step": TutorialStep.callInitiation,
      "title": "Inicia la Llamada",
      "description":
          "Una vez que hayas marcado el número, toca el botón verde de llamar.",
      "guidance":
          "¡Perfecto! Ahora toca el botón verde con el ícono de teléfono para iniciar la llamada simulada.",
    },
    {
      "step": TutorialStep.callInterface,
      "title": "Durante la Llamada",
      "description":
          "Esta es la pantalla que verás cuando estés en una llamada real.",
      "guidance":
          "Aquí puedes ver el nombre de la persona, el tiempo de llamada y los controles disponibles.",
    },
    {
      "step": TutorialStep.callControls,
      "title": "Controles de Llamada",
      "description":
          "Puedes silenciar, activar altavoz o finalizar la llamada usando estos botones.",
      "guidance":
          "Prueba tocar los diferentes botones para familiarizarte con los controles.",
    },
  ];

  @override
  void initState() {
    super.initState();
    // Start with introduction overlay
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showIntroductionGuidance();
    });
  }

  void _showIntroductionGuidance() {
    setState(() {
      _showGuidanceOverlay = true;
    });
  }

  void _nextStep() {
    HapticFeedback.lightImpact();

    switch (_currentStep) {
      case TutorialStep.introduction:
        setState(() {
          _currentStep = TutorialStep.dialerExplanation;
          _showGuidanceOverlay = true;
        });
        break;
      case TutorialStep.dialerExplanation:
        setState(() {
          _currentStep = TutorialStep.numberEntry;
          _showGuidanceOverlay = true;
        });
        break;
      case TutorialStep.numberEntry:
        if (_phoneNumber.length >= 9) {
          setState(() {
            _currentStep = TutorialStep.callInitiation;
            _showGuidanceOverlay = true;
          });
        }
        break;
      case TutorialStep.callInitiation:
        if (_hasInitiatedCall) {
          setState(() {
            _currentStep = TutorialStep.callInterface;
            _showGuidanceOverlay = true;
          });
        }
        break;
      case TutorialStep.callInterface:
        setState(() {
          _currentStep = TutorialStep.callControls;
          _showGuidanceOverlay = false;
        });
        break;
      case TutorialStep.callControls:
        setState(() {
          _currentStep = TutorialStep.completion;
          _showGuidanceOverlay = false;
        });
        break;
      case TutorialStep.completion:
        break;
    }
  }

  void _onNumberPressed(String number) {
    HapticFeedback.lightImpact();
    if (_phoneNumber.length < 15) {
      setState(() {
        _phoneNumber += number;
        _hasInteractedWithKeypad = true;
      });

      // Auto-advance when user enters enough numbers
      if (_currentStep == TutorialStep.numberEntry &&
          _phoneNumber.length >= 9) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            _nextStep();
          }
        });
      }
    }
  }

  void _onDeletePressed() {
    HapticFeedback.lightImpact();
    if (_phoneNumber.isNotEmpty) {
      setState(() {
        _phoneNumber = _phoneNumber.substring(0, _phoneNumber.length - 1);
      });
    }
  }

  void _onCallPressed() {
    if (_phoneNumber.isNotEmpty) {
      HapticFeedback.mediumImpact();
      setState(() {
        _hasInitiatedCall = true;
      });
      _nextStep();
    }
  }

  void _onEndCall() {
    HapticFeedback.mediumImpact();
    setState(() {
      _currentStep = TutorialStep.completion;
      _showGuidanceOverlay = false;
    });
  }

  void _onRepeatTutorial() {
    HapticFeedback.lightImpact();
    setState(() {
      _currentStep = TutorialStep.introduction;
      _phoneNumber = '';
      _showGuidanceOverlay = true;
      _hasInteractedWithKeypad = false;
      _hasInitiatedCall = false;
    });
    _showIntroductionGuidance();
  }

  void _onNextTutorial() {
    HapticFeedback.lightImpact();
    Navigator.pushNamed(context, '/tutorial-selection-interface');
  }

  void _onExitTutorial() {
    HapticFeedback.lightImpact();
    Navigator.pushNamed(context, '/main-launcher-home');
  }

  void _dismissGuidance() {
    setState(() {
      _showGuidanceOverlay = false;
    });
  }

  String _getCurrentStepDescription() {
    final stepData = _tutorialSteps.firstWhere(
      (step) => step["step"] == _currentStep,
      orElse: () => _tutorialSteps[0],
    );
    return stepData["description"] as String;
  }

  String _getCurrentGuidanceMessage() {
    final stepData = _tutorialSteps.firstWhere(
      (step) => step["step"] == _currentStep,
      orElse: () => _tutorialSteps[0],
    );
    return stepData["guidance"] as String;
  }

  int _getCurrentStepNumber() {
    return _tutorialSteps.indexWhere((step) => step["step"] == _currentStep) +
        1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              // Header
              TutorialHeaderWidget(
                onExit: _onExitTutorial,
              ),
              // Main content
              Expanded(
                child: _buildMainContent(),
              ),
            ],
          ),
          // Guidance overlay
          if (_showGuidanceOverlay && _currentStep != TutorialStep.completion)
            TutorialGuidanceOverlayWidget(
              message: _getCurrentGuidanceMessage(),
              onNext: _currentStep == TutorialStep.numberEntry &&
                      _phoneNumber.length < 9
                  ? null
                  : _nextStep,
              onSkip: _currentStep == TutorialStep.introduction
                  ? null
                  : _dismissGuidance,
              showPulse: _currentStep == TutorialStep.callInitiation &&
                  _phoneNumber.isNotEmpty,
            ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    switch (_currentStep) {
      case TutorialStep.completion:
        return TutorialCompletionWidget(
          onRepeat: _onRepeatTutorial,
          onNext: _onNextTutorial,
          onExit: _onExitTutorial,
        );
      case TutorialStep.callInterface:
      case TutorialStep.callControls:
        return SimulatedCallInterfaceWidget(
          contactName: 'Contacto de Prueba',
          phoneNumber: _phoneNumber,
          onEndCall: _onEndCall,
          onNextStep: _nextStep,
        );
      default:
        return Column(
          children: [
            // Progress indicator
            if (_currentStep != TutorialStep.completion)
              TutorialProgressWidget(
                currentStep: _getCurrentStepNumber(),
                totalSteps: _tutorialSteps.length - 1, // Exclude completion
                stepDescription: _getCurrentStepDescription(),
              ),
            // Dialer interface
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 2.h),
                    // Keypad
                    DialerKeypadWidget(
                      phoneNumber: _phoneNumber,
                      onNumberPressed: _onNumberPressed,
                      onDeletePressed: _onDeletePressed,
                    ),
                    SizedBox(height: 4.h),
                    // Call button
                    CallActionButtonWidget(
                      isEnabled: _phoneNumber.isNotEmpty,
                      onPressed: _onCallPressed,
                      phoneNumber: _phoneNumber,
                    ),
                    SizedBox(height: 4.h),
                  ],
                ),
              ),
            ),
          ],
        );
    }
  }
}
