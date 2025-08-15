import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/progress_indicator_widget.dart';
import './widgets/search_bar_widget.dart';
import './widgets/tutorial_card_widget.dart';

class HelpCenterMenu extends StatefulWidget {
  const HelpCenterMenu({Key? key}) : super(key: key);

  @override
  State<HelpCenterMenu> createState() => _HelpCenterMenuState();
}

class _HelpCenterMenuState extends State<HelpCenterMenu> {
  String _searchQuery = '';
  bool _isRefreshing = false;

  // Mock tutorial data with WhatsApp tutorial added
  final List<Map<String, dynamic>> _tutorials = [
    {
      "id": 1,
      "iconName": "phone",
      "title": "Hacer Llamadas",
      "description":
          "Aprende a realizar llamadas telefónicas paso a paso. Incluye cómo marcar números, usar contactos y gestionar llamadas entrantes.",
      "duration": "5-8 minutos",
      "isCompleted": true,
      "category": "comunicacion",
      "difficulty": "basico",
    },
    {
      "id": 2,
      "iconName": "chat",
      "title": "Tutorial WhatsApp",
      "description":
          "Descubre cómo usar WhatsApp para enviar mensajes, fotos, audios y hacer videollamadas con tu familia de manera sencilla y segura.",
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
          "Descubre cómo enviar mensajes de texto y multimedia. Aprende a escribir, enviar y recibir mensajes de manera sencilla.",
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
          "Toma fotos y videos con facilidad. Aprende los controles básicos de la cámara y cómo guardar tus recuerdos.",
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
          "Organiza tu lista de contactos. Aprende a agregar, editar y eliminar contactos de manera eficiente.",
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
          "Aprende a encender y apagar la linterna de tu teléfono para iluminar en lugares oscuros de forma práctica.",
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
          "Domina el uso de la calculadora para realizar operaciones matemáticas básicas y avanzadas de manera sencilla.",
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
          "Consulta el pronóstico del tiempo, temperaturas y condiciones climáticas para planificar mejor tu día.",
      "duration": "4-6 minutos",
      "isCompleted": false,
      "category": "informacion",
      "difficulty": "basico",
    },
    {
      "id": 9,
      "iconName": "emergency",
      "title": "Funciones de Emergencia",
      "description":
          "Conoce las funciones de emergencia de tu teléfono. Aprende a usar el botón de emergencia y contactar servicios de urgencia.",
      "duration": "3-5 minutos",
      "isCompleted": true,
      "category": "seguridad",
      "difficulty": "basico",
    },
    {
      "id": 10,
      "iconName": "settings",
      "title": "Configuración Básica",
      "description":
          "Personaliza tu teléfono según tus necesidades. Ajusta volumen, brillo y otras configuraciones importantes.",
      "duration": "8-15 minutos",
      "isCompleted": false,
      "category": "configuracion",
      "difficulty": "intermedio",
    },
    {
      "id": 11,
      "iconName": "wifi",
      "title": "Conectar a Internet",
      "description":
          "Aprende a conectarte a redes WiFi y usar datos móviles de forma segura y eficiente.",
      "duration": "5-9 minutos",
      "isCompleted": false,
      "category": "conectividad",
      "difficulty": "intermedio",
    },
    {
      "id": 12,
      "iconName": "volume_up",
      "title": "Control de Sonido",
      "description":
          "Domina los controles de audio de tu dispositivo. Ajusta volúmenes, tonos y notificaciones sonoras.",
      "duration": "4-6 minutos",
      "isCompleted": false,
      "category": "configuracion",
      "difficulty": "basico",
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
    final String tutorialTitle = tutorial["title"] as String;

    // Navigate based on tutorial type
    switch (tutorial["id"] as int) {
      case 1: // Hacer Llamadas
        Navigator.pushNamed(context, '/interactive-call-tutorial');
        break;
      case 2: // Tutorial WhatsApp
        Navigator.pushNamed(context, '/whats-app-tutorial-guide');
        break;
      case 3: // Enviar Mensajes
      case 4: // Usar Cámara
      case 5: // Gestionar Contactos
      case 6: // Usar la Linterna
      case 7: // Usar la Calculadora
      case 8: // Ver el Clima
      case 10: // Configuración Básica
      case 11: // Conectar a Internet
      case 12: // Control de Sonido
        Navigator.pushNamed(context, '/tutorial-selection-interface');
        break;
      case 9: // Funciones de Emergencia
        Navigator.pushNamed(context, '/emergency-call-interface');
        break;
      default:
        Navigator.pushNamed(context, '/tutorial-selection-interface');
    }
  }

  void _handleVoiceSearch() {
    // Voice search functionality would be implemented here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Función de búsqueda por voz próximamente disponible',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.surface,
            fontSize: 16.sp,
          ),
        ),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  void _startRecommendedTutorial() {
    // Find first incomplete tutorial
    final incompletetutorials = _tutorials
        .where((tutorial) => !(tutorial["isCompleted"] as bool))
        .toList();

    if (incompletetutorials.isNotEmpty) {
      _handleTutorialTap(incompletetutorials.first);
    } else {
      // All tutorials completed, show congratulations
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '¡Felicitaciones! Has completado todos los tutoriales disponibles',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.surface,
              fontSize: 16.sp,
            ),
          ),
          backgroundColor: AppTheme.successFeedback,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
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
            size: 7.w,
          ),
          iconSize: 7.w,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Centro de Ayuda',
              style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
            Text(
              'Aprende a tu ritmo',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                fontSize: 16.sp,
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
                    width: 5.w,
                    height: 5.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppTheme.lightTheme.colorScheme.primary,
                      ),
                    ),
                  )
                : CustomIconWidget(
                    iconName: 'refresh',
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                    size: 6.w,
                  ),
          ),
          SizedBox(width: 2.w),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          color: AppTheme.lightTheme.colorScheme.primary,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Search bar
              SliverToBoxAdapter(
                child: SearchBarWidget(
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
                child: ProgressIndicatorWidget(
                  completedTutorials: _completedTutorialsCount,
                  totalTutorials: _tutorials.length,
                ),
              ),

              // Section header
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'school',
                        color: AppTheme.lightTheme.colorScheme.primary,
                        size: 7.w,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Tutoriales Disponibles',
                        style:
                            AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.lightTheme.colorScheme.onSurface,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '${_filteredTutorials.length} tutoriales',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          fontSize: 16.sp,
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Tutorial cards
              _filteredTutorials.isEmpty
                  ? SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 4.h),
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(
                          color: AppTheme.lightTheme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: AppTheme.lightTheme.colorScheme.outline,
                            width: 1.0,
                          ),
                        ),
                        child: Column(
                          children: [
                            CustomIconWidget(
                              iconName: 'search_off',
                              color: AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                              size: 12.w,
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'No se encontraron tutoriales',
                              style: AppTheme.lightTheme.textTheme.titleMedium
                                  ?.copyWith(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                color:
                                    AppTheme.lightTheme.colorScheme.onSurface,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              'Intenta con otros términos de búsqueda',
                              style: AppTheme.lightTheme.textTheme.bodyMedium
                                  ?.copyWith(
                                fontSize: 18.sp,
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
                          return TutorialCardWidget(
                            iconName: tutorial["iconName"] as String,
                            title: tutorial["title"] as String,
                            description: tutorial["description"] as String,
                            duration: tutorial["duration"] as String,
                            isCompleted: tutorial["isCompleted"] as bool,
                            onTap: () => _handleTutorialTap(tutorial),
                          );
                        },
                        childCount: _filteredTutorials.length,
                      ),
                    ),

              // Bottom spacing
              SliverToBoxAdapter(
                child: SizedBox(height: 10.h),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _startRecommendedTutorial,
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        foregroundColor: AppTheme.lightTheme.colorScheme.surface,
        elevation: 4.0,
        icon: CustomIconWidget(
          iconName: 'play_arrow',
          color: AppTheme.lightTheme.colorScheme.surface,
          size: 6.w,
        ),
        label: Text(
          'Comenzar Tutorial',
          style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppTheme.lightTheme.colorScheme.surface,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
