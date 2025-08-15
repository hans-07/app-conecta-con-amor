import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/tutorial_card_widget.dart';
import './widgets/tutorial_context_menu_widget.dart';
import './widgets/tutorial_filter_chips_widget.dart';
import './widgets/tutorial_preview_modal_widget.dart';
import './widgets/tutorial_search_bar_widget.dart';

class TutorialSelectionInterface extends StatefulWidget {
  const TutorialSelectionInterface({Key? key}) : super(key: key);

  @override
  State<TutorialSelectionInterface> createState() =>
      _TutorialSelectionInterfaceState();
}

class _TutorialSelectionInterfaceState
    extends State<TutorialSelectionInterface> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'todos';
  String _searchQuery = '';

  final List<Map<String, dynamic>> _tutorials = [
    {
      'id': 1,
      'title': 'Cómo Hacer una Llamada',
      'description':
          'Aprende a realizar llamadas telefónicas paso a paso. Incluye cómo marcar números, usar contactos y gestionar llamadas entrantes.',
      'difficulty': 'Básico',
      'duration': '8 min',
      'icon': 'phone',
      'completed': true,
      'favorite': true,
      'category': 'comunicacion',
      'objectives': [
        'Aprender a abrir la aplicación de teléfono',
        'Marcar números manualmente',
        'Llamar desde la lista de contactos',
        'Responder y colgar llamadas'
      ],
    },
    {
      'id': 2,
      'title': 'Enviar Mensajes de Texto',
      'description':
          'Domina el arte de enviar mensajes SMS. Desde escribir tu primer mensaje hasta usar emojis y adjuntar fotos.',
      'difficulty': 'Básico',
      'duration': '10 min',
      'icon': 'message',
      'completed': false,
      'favorite': false,
      'category': 'comunicacion',
      'objectives': [
        'Abrir la aplicación de mensajes',
        'Crear un nuevo mensaje',
        'Seleccionar contactos',
        'Enviar mensajes con emojis'
      ],
    },
    {
      'id': 3,
      'title': 'Gestionar Contactos',
      'description':
          'Organiza tu agenda telefónica. Aprende a agregar, editar y eliminar contactos de manera sencilla.',
      'difficulty': 'Básico',
      'duration': '12 min',
      'icon': 'contacts',
      'completed': false,
      'favorite': true,
      'category': 'organizacion',
      'objectives': [
        'Agregar nuevos contactos',
        'Editar información existente',
        'Organizar contactos en grupos',
        'Buscar contactos rápidamente'
      ],
    },
    {
      'id': 4,
      'title': 'Tomar Fotos con la Cámara',
      'description':
          'Captura momentos especiales. Tutorial completo sobre cómo usar la cámara, tomar fotos y guardarlas en tu galería.',
      'difficulty': 'Intermedio',
      'duration': '15 min',
      'icon': 'camera_alt',
      'completed': true,
      'favorite': false,
      'category': 'multimedia',
      'objectives': [
        'Abrir y configurar la cámara',
        'Tomar fotos de calidad',
        'Usar el flash correctamente',
        'Guardar y organizar fotos'
      ],
    },
    {
      'id': 5,
      'title': 'Configurar Wi-Fi',
      'description':
          'Conecta tu teléfono a internet. Aprende a buscar redes Wi-Fi, conectarte y gestionar conexiones guardadas.',
      'difficulty': 'Intermedio',
      'duration': '18 min',
      'icon': 'wifi',
      'completed': false,
      'favorite': false,
      'category': 'configuracion',
      'objectives': [
        'Buscar redes Wi-Fi disponibles',
        'Conectarse con contraseña',
        'Gestionar redes guardadas',
        'Solucionar problemas de conexión'
      ],
    },
    {
      'id': 6,
      'title': 'Usar el Botón de Emergencia',
      'description':
          'Función vital de seguridad. Aprende cuándo y cómo usar el botón de emergencia para contactar servicios de urgencia.',
      'difficulty': 'Básico',
      'duration': '6 min',
      'icon': 'emergency',
      'completed': false,
      'favorite': true,
      'category': 'seguridad',
      'objectives': [
        'Identificar situaciones de emergencia',
        'Usar el botón de emergencia correctamente',
        'Comunicarse con operadores',
        'Proporcionar información importante'
      ],
    },
    {
      'id': 7,
      'title': 'Ajustar Volumen y Sonidos',
      'description':
          'Personaliza el audio de tu teléfono. Controla el volumen de llamadas, notificaciones y multimedia.',
      'difficulty': 'Básico',
      'duration': '7 min',
      'icon': 'volume_up',
      'completed': true,
      'favorite': false,
      'category': 'configuracion',
      'objectives': [
        'Ajustar volumen de llamadas',
        'Configurar tonos de notificación',
        'Activar modo silencioso',
        'Personalizar sonidos del sistema'
      ],
    },
    {
      'id': 8,
      'title': 'Navegar por Internet',
      'description':
          'Explora el mundo digital. Tutorial sobre cómo usar el navegador web, buscar información y navegar de forma segura.',
      'difficulty': 'Intermedio',
      'duration': '20 min',
      'icon': 'language',
      'completed': false,
      'favorite': false,
      'category': 'internet',
      'objectives': [
        'Abrir el navegador web',
        'Realizar búsquedas en Google',
        'Navegar entre páginas web',
        'Guardar sitios favoritos'
      ],
    },
  ];

  List<Map<String, dynamic>> get _filteredTutorials {
    List<Map<String, dynamic>> filtered = _tutorials;

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((tutorial) {
        final title = (tutorial['title'] as String).toLowerCase();
        final description = (tutorial['description'] as String).toLowerCase();
        final query = _searchQuery.toLowerCase();
        return title.contains(query) || description.contains(query);
      }).toList();
    }

    // Apply category filter
    switch (_selectedFilter) {
      case 'basico':
        filtered = filtered
            .where((tutorial) =>
                (tutorial['difficulty'] as String).toLowerCase() == 'básico')
            .toList();
        break;
      case 'intermedio':
        filtered = filtered
            .where((tutorial) =>
                (tutorial['difficulty'] as String).toLowerCase() ==
                'intermedio')
            .toList();
        break;
      case 'completados':
        filtered = filtered
            .where((tutorial) => tutorial['completed'] as bool? ?? false)
            .toList();
        break;
      case 'favoritos':
        filtered = filtered
            .where((tutorial) => tutorial['favorite'] as bool? ?? false)
            .toList();
        break;
      default:
        break;
    }

    return filtered;
  }

  Map<String, dynamic>? get _recommendedTutorial {
    // Find first uncompleted basic tutorial
    final uncompletedBasic = _tutorials
        .where((tutorial) =>
            !(tutorial['completed'] as bool? ?? false) &&
            (tutorial['difficulty'] as String).toLowerCase() == 'básico')
        .toList();

    return uncompletedBasic.isNotEmpty ? uncompletedBasic.first : null;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildBreadcrumb(),
          TutorialSearchBarWidget(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            onVoiceSearch: _handleVoiceSearch,
          ),
          TutorialFilterChipsWidget(
            selectedFilter: _selectedFilter,
            onFilterChanged: (filter) {
              setState(() {
                _selectedFilter = filter;
              });
            },
          ),
          SizedBox(height: 2.h),
          Expanded(
            child: _buildTutorialGrid(),
          ),
        ],
      ),
      floatingActionButton:
          _recommendedTutorial != null ? _buildRecommendedButton() : null,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppTheme.lightTheme.colorScheme.outline,
              width: 2,
            ),
          ),
          child: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.textPrimary,
            size: 6.w,
          ),
        ),
      ),
      title: Text(
        'Seleccionar Tutorial',
        style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 20.sp,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildBreadcrumb() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: 'home',
            color: AppTheme.textSecondary,
            size: 4.w,
          ),
          SizedBox(width: 1.w),
          Text(
            'Inicio',
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.textSecondary,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(width: 1.w),
          CustomIconWidget(
            iconName: 'arrow_forward_ios',
            color: AppTheme.textSecondary,
            size: 3.w,
          ),
          SizedBox(width: 1.w),
          Text(
            'Centro de Ayuda',
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.textSecondary,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(width: 1.w),
          CustomIconWidget(
            iconName: 'arrow_forward_ios',
            color: AppTheme.textSecondary,
            size: 3.w,
          ),
          SizedBox(width: 1.w),
          Text(
            'Tutoriales',
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.phoneAction,
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTutorialGrid() {
    final filteredTutorials = _filteredTutorials;

    if (filteredTutorials.isEmpty) {
      return _buildEmptyState();
    }

    return OrientationBuilder(
      builder: (context, orientation) {
        final crossAxisCount = orientation == Orientation.portrait ? 1 : 2;

        return GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: orientation == Orientation.portrait ? 2.5 : 1.8,
            crossAxisSpacing: 2.w,
            mainAxisSpacing: 1.h,
          ),
          itemCount: filteredTutorials.length,
          itemBuilder: (context, index) {
            final tutorial = filteredTutorials[index];
            return TutorialCardWidget(
              tutorial: tutorial,
              onTap: () => _showTutorialPreview(tutorial),
              onLongPress: () => _showContextMenu(tutorial),
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.outline
                  .withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: CustomIconWidget(
              iconName: 'search_off',
              color: AppTheme.textSecondary,
              size: 12.w,
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            'No se encontraron tutoriales',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Intenta cambiar los filtros o\nbuscar con otras palabras',
            textAlign: TextAlign.center,
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 3.h),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedFilter = 'todos';
                _searchQuery = '';
                _searchController.clear();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.phoneAction,
              foregroundColor: AppTheme.lightTheme.colorScheme.onPrimary,
              minimumSize: Size(40.w, 6.h),
            ),
            child: Text(
              'Limpiar Filtros',
              style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onPrimary,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget? _buildRecommendedButton() {
    final recommended = _recommendedTutorial;
    if (recommended == null) return null;

    return FloatingActionButton.extended(
      onPressed: () => _startTutorial(recommended),
      backgroundColor: AppTheme.phoneAction,
      foregroundColor: AppTheme.lightTheme.colorScheme.onPrimary,
      icon: CustomIconWidget(
        iconName: 'star',
        color: AppTheme.lightTheme.colorScheme.onPrimary,
        size: 6.w,
      ),
      label: Text(
        'Recomendado',
        style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
          color: AppTheme.lightTheme.colorScheme.onPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
        ),
      ),
    );
  }

  void _showTutorialPreview(Map<String, dynamic> tutorial) {
    showDialog(
      context: context,
      builder: (context) => TutorialPreviewModalWidget(
        tutorial: tutorial,
        onStart: () {
          Navigator.pop(context);
          _startTutorial(tutorial);
        },
        onClose: () => Navigator.pop(context),
      ),
    );
  }

  void _showContextMenu(Map<String, dynamic> tutorial) {
    showDialog(
      context: context,
      builder: (context) => TutorialContextMenuWidget(
        tutorial: tutorial,
        onMarkFavorite: () {
          Navigator.pop(context);
          _toggleFavorite(tutorial);
        },
        onViewProgress: () {
          Navigator.pop(context);
          _viewProgress(tutorial);
        },
        onReset: () {
          Navigator.pop(context);
          _resetTutorial(tutorial);
        },
        onClose: () => Navigator.pop(context),
      ),
    );
  }

  void _startTutorial(Map<String, dynamic> tutorial) {
    // Navigate to specific tutorial based on type
    final String tutorialType = tutorial['category'] as String? ?? 'general';

    switch (tutorialType) {
      case 'comunicacion':
        if ((tutorial['title'] as String).contains('Llamada')) {
          Navigator.pushNamed(context, '/interactive-call-tutorial');
        } else {
          _showTutorialNotAvailable(tutorial);
        }
        break;
      case 'seguridad':
        Navigator.pushNamed(context, '/emergency-call-interface');
        break;
      default:
        _showTutorialNotAvailable(tutorial);
        break;
    }
  }

  void _showTutorialNotAvailable(Map<String, dynamic> tutorial) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Tutorial "${tutorial['title']}" estará disponible pronto',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onPrimary,
            fontSize: 14.sp,
          ),
        ),
        backgroundColor: AppTheme.phoneAction,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _toggleFavorite(Map<String, dynamic> tutorial) {
    setState(() {
      final index = _tutorials.indexWhere((t) => t['id'] == tutorial['id']);
      if (index != -1) {
        _tutorials[index]['favorite'] =
            !(tutorial['favorite'] as bool? ?? false);
      }
    });

    final isFavorite = tutorial['favorite'] as bool? ?? false;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite ? 'Eliminado de favoritos' : 'Agregado a favoritos',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onPrimary,
            fontSize: 14.sp,
          ),
        ),
        backgroundColor: AppTheme.phoneAction,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _viewProgress(Map<String, dynamic> tutorial) {
    final bool isCompleted = tutorial['completed'] as bool? ?? false;
    final String progressText = isCompleted ? 'Completado' : 'Sin completar';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Progreso: $progressText',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onPrimary,
            fontSize: 14.sp,
          ),
        ),
        backgroundColor:
            isCompleted ? AppTheme.successFeedback : AppTheme.contactsAction,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _resetTutorial(Map<String, dynamic> tutorial) {
    setState(() {
      final index = _tutorials.indexWhere((t) => t['id'] == tutorial['id']);
      if (index != -1) {
        _tutorials[index]['completed'] = false;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Tutorial reiniciado correctamente',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onPrimary,
            fontSize: 14.sp,
          ),
        ),
        backgroundColor: AppTheme.contactsAction,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleVoiceSearch() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Búsqueda por voz no disponible en esta versión',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onPrimary,
            fontSize: 14.sp,
          ),
        ),
        backgroundColor: AppTheme.textSecondary,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
