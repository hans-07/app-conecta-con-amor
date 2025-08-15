import 'package:flutter/material.dart';
import '../presentation/main_launcher_home/main_launcher_home.dart';
import '../presentation/enhanced_main_launcher_home/enhanced_main_launcher_home.dart';
import '../presentation/enhanced_help_center_menu/enhanced_help_center_menu.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/interactive_call_tutorial/interactive_call_tutorial.dart';
import '../presentation/tutorial_selection_interface/tutorial_selection_interface.dart';
import '../presentation/help_center_menu/help_center_menu.dart';
import '../presentation/emergency_call_interface/emergency_call_interface.dart';
import '../presentation/whats_app_tutorial_guide/whats_app_tutorial_guide.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String mainLauncherHome = '/main-launcher-home';
  static const String enhancedMainLauncherHome = '/enhanced-main-launcher-home';
  static const String enhancedHelpCenterMenu = '/enhanced-help-center-menu';
  static const String splash = '/splash-screen';
  static const String interactiveCallTutorial = '/interactive-call-tutorial';
  static const String tutorialSelectionInterface =
      '/tutorial-selection-interface';
  static const String helpCenterMenu = '/help-center-menu';
  static const String emergencyCallInterface = '/emergency-call-interface';
  static const String whatsAppTutorialGuide = '/whats-app-tutorial-guide';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashScreen(),
    mainLauncherHome: (context) => const MainLauncherHome(),
    enhancedMainLauncherHome: (context) => const EnhancedMainLauncherHome(),
    enhancedHelpCenterMenu: (context) => const EnhancedHelpCenterMenu(),
    splash: (context) => const SplashScreen(),
    interactiveCallTutorial: (context) => const InteractiveCallTutorial(),
    tutorialSelectionInterface: (context) => const TutorialSelectionInterface(),
    helpCenterMenu: (context) => const HelpCenterMenu(),
    emergencyCallInterface: (context) => const EmergencyCallInterface(),
    whatsAppTutorialGuide: (context) => const WhatsAppTutorialGuide(),
    // TODO: Add your other routes here
  };
}
