import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/enhanced_progress_indicator_widget.dart';
import './widgets/enhanced_search_bar_widget.dart';
import './widgets/enhanced_tutorial_card_widget.dart';

class EnhancedHelpCenterMenu extends StatefulWidget {
  const EnhancedHelpCenterMenu({Key? key}) : super(key: key);

  @override
  State<EnhancedHelpCenterMenu> createState() => _EnhancedHelpCenterMenuState();
}

class _EnhancedHelpCenterMenuState extends State<EnhancedHelpCenterMenu> {
  String _searchQuery = '';
  bool _isRefreshing = false;

  // Enhanced tutorial data with more useful features for seniors
  final List<Map<String, dynamic>> _tutorials = [
    {
      "id": 1,
      "iconName": "phone",
      "title": "Hacer Llamadas",
      "description":
          "Aprende a realizar llamadas telefónicas paso a paso. Incluye cómo marcar números, usar contactos y gestionar llamadas entrantes de forma sencilla.",
      "duration": "5-8 minutos",
      "isCompleted": true,
      "category": "comunicacion",
      "difficulty": "basico",
    },
    {
      "id": 2,
      "iconName": "chat",
      "title": "Usar WhatsApp",
      "description":
          "Tutorial completo de WhatsApp: envía mensajes, fotos, audios y haz videollamadas con tu familia de manera segura y fácil.",
      "duration": "10-15 minutos",
      "isCompleted": false,
      "category": "comunicacion",
      "difficulty": "basico",
    },
    {
      "id": 3,
      "iconName": "message",
      "title": "Enviar Mensajes",
      "description":
          "Domina el envío de mensajes de texto y multimedia. Aprende a escribir, enviar y recibir mensajes de manera práctica.",
      "duration": "6-10 minutos",
      "isCompleted": false,
      "category": "comunicacion",
      "difficulty": "basico",
    },
    {
      "id": 4,
      "iconName": "camera_alt",
      "title": "Usar Cámara",
      "description":
          "Toma fotos hermosas y videos memorables con facilidad. Aprende los controles básicos y cómo guardar tus recuerdos.",
      "duration": "4-7 minutos",
      "isCompleted": true,
      "category": "multimedia",
      "difficulty": "basico",
    },
    {
      "id": 5,
      "iconName": "contacts",
      "title": "Gestionar Contactos",
      "description":
          "Organiza perfectamente tu lista de contactos. Aprende a agregar, editar y eliminar contactos de manera eficiente.",
      "duration": "7-12 minutos",
      "isCompleted": false,
      "category": "organizacion",
      "difficulty": "intermedio",
    },
    {
      "id": 6,
      "iconName": "flashlight_on",
      "title": "Usar la Linterna",
      "description":
          "Ilumina cualquier lugar oscuro usando la linterna de tu teléfono. Aprende a encenderla y apagarla rápidamente.",
      "duration": "2-3 minutos",
      "isCompleted": false,
      "category": "utilidades",
      "difficulty": "basico",
    },
    {
      "id": 7,
      "iconName": "calculate",
      "title": "Usar la Calculadora",
      "description":
          "Realiza cálculos matemáticos básicos y avanzados con la calculadora de tu teléfono de manera sencilla y práctica.",
      "duration": "3-5 minutos",
      "isCompleted": false,
      "category": "utilidades",
      "difficulty": "basico",
    },
    {
      "id": 8,
      "iconName": "wb_sunny",
      "title": "Ver el Clima",
      "description":
          "Consulta el pronóstico del tiempo, temperaturas y condiciones climáticas para planificar mejor tus actividades diarias.",
      "duration": "4-6 minutos",
      "isCompleted": false,
      "category": "informacion",
      "difficulty": "basico",
    },
    {
      "id": 9,
      "iconName": "alarm",
      "title": "Configurar Alarmas",
      "description":
          "Programa alarmas para recordatorios importantes, medicinas o citas médicas. Nunca olvides algo importante otra vez.",
      "duration": "3-5 minutos",
      "isCompleted": false,
      "category": "utilidades",
      "difficulty": "basico",
    },
    {
      "id": 10,
      "iconName": "music_note",
      "title": "Escuchar Música",
      "description":
          "Disfruta de tu música favorita desde tu teléfono. Aprende a reproducir, pausar y controlar el volumen fácilmente.",
      "duration": "5-8 minutos",
      "isCompleted": false,
      "category": "entretenimiento",
      "difficulty": "basico",
    },
    {
      "id": 11,
      "iconName": "emergency",
      "title": "Funciones de Emergencia",
      "description":
          "Funciones vitales de seguridad: usa el botón de emergencia, contacta servicios de urgencia y configura contactos de emergencia.",
      "duration": "3-5 minutos",
      "isCompleted": true,
      "category": "seguridad",
      "difficulty": "basico",
    },
    {
      "id": 12,
      "iconName": "settings",
      "title": "Configuración Básica",
      "description":
          "Personaliza tu teléfono según tus necesidades. Ajusta volumen, brillo, tamaño de letra y otras configuraciones importantes.",
      "duration": "8-15 minutos",
      "isCompleted": false,
      "category": "configuracion",
      "difficulty": "intermedio",
    },
    {
      "id": 13,
      "iconName": "wifi",
      "title": "Conectar a Internet",
      "description":
          "Conéctate a redes WiFi seguras y gestiona tus datos móviles de forma eficiente para ahorrar en tu plan.",
      "duration": "5-9 minutos",
      "isCompleted": false,
      "category": "conectividad",
      "difficulty": "intermedio",
    },
    {
      "id": 14,
      "iconName": "volume_up",
      "title": "Control de Sonido",
      "description":
          "Domina todos los controles de audio: ajusta volúmenes, tonos de llamada, notificaciones y usa el altavoz.",
      "duration": "4-6 minutos",
      "isCompleted": false,
      "category": "configuracion",
      "difficulty": "basico",
    },
    {
      "id": 15,
      "iconName": "medication",
      "title": "Recordatorio de Medicinas",
      "description":
          "Configura recordatorios para tomar tus medicamentos a tiempo. Nunca olvides una dosis importante.",
      "duration": "6-10 minutos",
      "isCompleted": false,
      "category": "salud",
      "difficulty": "intermedio",
    },
  ];

  List<Map<String, dynamic>> get _filteredTutorials {
    if (_searchQuery.isEmpty) {
      return _tutorials;
    }
    return _tutorials.where((tutorial) {
      final title = (tutorial["title"] as String).toLowerCase();
      final description = (tutorial["description"] as String).toLowerCase();
      final query = _searchQuery.toLowerCase();
      return title.contains(query) || description.contains(query);
    }).toList();
  }

  int get _completedTutorialsCount {
    return _tutorials
        .where((tutorial) => tutorial["isCompleted"] as bool)
        .length;
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate refresh delay
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isRefreshing = false;
    });
  }

  void _handleTutorialTap(Map<String, dynamic> tutorial) {
    HapticFeedback.lightImpact();

    // Navigate based on tutorial type
    switch (tutorial["id"] as int) {
      case 1: // Hacer Llamadas
        Navigator.pushNamed(context, AppRoutes.interactiveCallTutorial);
        break;
      case 2: // Tutorial WhatsApp
        Navigator.pushNamed(context, AppRoutes.whatsAppTutorialGuide);
        break;
      case 11: // Funciones de Emergencia
        Navigator.pushNamed(context, AppRoutes.emergencyCallInterface);
        break;
      default:
        Navigator.pushNamed(context, AppRoutes.tutorialSelectionInterface);
    }
  }

  void _handleVoiceSearch() {
    HapticFeedback.mediumImpact();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Función de búsqueda por voz próximamente disponible',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.surface,
            fontSize: 20.sp,
          ),
        ),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _startRecommendedTutorial() {
    HapticFeedback.mediumImpact();

    // Find first incomplete tutorial
    final incompleteTutorials = _tutorials
        .where((tutorial) => !(tutorial["isCompleted"] as bool))
        .toList();

    if (incompleteTutorials.isNotEmpty) {
      _handleTutorialTap(incompleteTutorials.first);
    } else {
      // All tutorials completed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '¡Felicitaciones! Has completado todos los tutoriales disponibles',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.surface,
              fontSize: 20.sp,
            ),
          ),
          backgroundColor: AppTheme.successFeedback,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor,
        elevation: AppTheme.lightTheme.appBarTheme.elevation,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.lightTheme.colorScheme.onSurface,
            size: 9.w,
          ),
          iconSize: 9.w,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Centro de Ayuda',
              style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                fontSize: 32.sp, // Extra large font as requested
                fontWeight: FontWeight.w700,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
            Text(
              'Aprende a usar tu teléfono paso a paso',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                fontSize: 20.sp, // Larger subtitle
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _handleRefresh,
            icon: _isRefreshing
                ? SizedBox(
                    width: 7.w,
                    height: 7.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 3.0,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppTheme.lightTheme.colorScheme.primary,
                      ),
                    ),
                  )
                : CustomIconWidget(
                    iconName: 'refresh',
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                    size: 8.w,
                  ),
          ),
          SizedBox(width: 2.w),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          color: AppTheme.lightTheme.colorScheme.primary,
          strokeWidth: 3.0,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(), // Enhanced scrolling
            slivers: [
              // Search bar
              SliverToBoxAdapter(
                child: EnhancedSearchBarWidget(
                  onSearchChanged: (query) {
                    setState(() {
                      _searchQuery = query;
                    });
                  },
                  onVoiceSearch: _handleVoiceSearch,
                ),
              ),

              // Progress indicator
              SliverToBoxAdapter(
                child: EnhancedProgressIndicatorWidget(
                  completedTutorials: _completedTutorialsCount,
                  totalTutorials: _tutorials.length,
                ),
              ),

              // Section header with enhanced typography
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: AppTheme.lightTheme.colorScheme.primary
                          .withValues(alpha: 0.2),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'school',
                        color: AppTheme.lightTheme.colorScheme.primary,
                        size: 9.w,
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tutoriales Disponibles',
                              style: AppTheme.lightTheme.textTheme.titleLarge
                                  ?.copyWith(
                                fontSize: 26.sp, // Larger font
                                fontWeight: FontWeight.w700,
                                color:
                                    AppTheme.lightTheme.colorScheme.onSurface,
                              ),
                            ),
                            SizedBox(height: 0.5.h),
                            Text(
                              '${_filteredTutorials.length} tutoriales para aprender',
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                fontSize: 18.sp, // Larger text
                                color: AppTheme
                                    .lightTheme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Tutorial cards with enhanced layout
              _filteredTutorials.isEmpty
                  ? SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 4.h),
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: AppTheme.lightTheme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color: AppTheme.lightTheme.colorScheme.outline,
                            width: 2.0,
                          ),
                        ),
                        child: Column(
                          children: [
                            CustomIconWidget(
                              iconName: 'search_off',
                              color: AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                              size: 15.w,
                            ),
                            SizedBox(height: 3.h),
                            Text(
                              'No se encontraron tutoriales',
                              style: AppTheme.lightTheme.textTheme.titleMedium
                                  ?.copyWith(
                                fontSize: 24.sp, // Larger font
                                fontWeight: FontWeight.w600,
                                color:
                                    AppTheme.lightTheme.colorScheme.onSurface,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'Intenta con otros términos de búsqueda',
                              style: AppTheme.lightTheme.textTheme.bodyMedium
                                  ?.copyWith(
                                fontSize: 20.sp, // Larger font
                                color: AppTheme
                                    .lightTheme.colorScheme.onSurfaceVariant,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final tutorial = _filteredTutorials[index];
                          return EnhancedTutorialCardWidget(
                            iconName: tutorial["iconName"] as String,
                            title: tutorial["title"] as String,
                            description: tutorial["description"] as String,
                            duration: tutorial["duration"] as String,
                            isCompleted: tutorial["isCompleted"] as bool,
                            category: tutorial["category"] as String,
                            onTap: () => _handleTutorialTap(tutorial),
                          );
                        },
                        childCount: _filteredTutorials.length,
                      ),
                    ),

              // Bottom spacing for floating button
              SliverToBoxAdapter(
                child: SizedBox(height: 12.h),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _startRecommendedTutorial,
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        foregroundColor: AppTheme.lightTheme.colorScheme.surface,
        elevation: 6.0,
        icon: CustomIconWidget(
          iconName: 'play_arrow',
          color: AppTheme.lightTheme.colorScheme.surface,
          size: 8.w,
        ),
        label: Text(
          'Comenzar Tutorial',
          style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
            fontSize: 20.sp, // Larger button text
            fontWeight: FontWeight.w600,
            color: AppTheme.lightTheme.colorScheme.surface,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
