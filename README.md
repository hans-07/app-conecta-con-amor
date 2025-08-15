# Flutter

Una aplicación móvil moderna basada en Flutter que utiliza las últimas tecnologías y herramientas de desarrollo móvil para crear aplicaciones responsivas multiplataforma

## 📋 Requisitos previos

- Flutter SDK (^3.29.2)
- Dart SDK
- Android Studio / VS Code con extensiones de Flutter
- Android SDK / Xcode (para desarrollo en iOS)

## 🛠️ Instalación

1. Instala las dependencias:
```bash
flutter pub get
```

2. Ejecuta la aplicación:
```bash
flutter run
```

## 📁 Estructura del proyecto

```
flutter_app/
├── android/            # Configuración específica de Android
├── ios/                # Configuración específica de iOS
├── lib/
│   ├── core/           # Utilidades y servicios principales
│   │   └── utils/      # Clases utilitarias
│   ├── presentation/   # Pantallas y widgets de la interfaz
│   │   └── splash_screen/ # Implementación de la pantalla de inicio
│   ├── routes/         # Rutas de la aplicación
│   ├── theme/          # Configuración de temas
│   ├── widgets/        # Componentes reutilizables de UI
│   └── main.dart       # Punto de entrada de la aplicación
├── assets/             # Recursos estáticos (imágenes, fuentes, etc.)
├── pubspec.yaml        # Dependencias y configuración del proyecto
└── README.md           # Documentación del proyecto
```

## 🧩 Adding Routes

Para agregar nuevas rutas a la aplicación, actualiza el archivo app_routes.dart:

```dart
import 'package:flutter/material.dart';
import 'package:package_name/presentation/home_screen/home_screen.dart';

class AppRoutes {
  static const String initial = '/';
  static const String home = '/home';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashScreen(),
    home: (context) => const HomeScreen(),
    // Agrega más rutas según sea necesario
  }
}
```

## 📱 Responsive Design

La app está construida con diseño responsivo usando el paquete Sizer:

```dart
// Ejemplo de tamaño responsivo
Container(
  width: 50.w, // 50% del ancho de la pantalla
  height: 20.h, // 20% de la altura de la pantalla
  child: Text('Contenedor responsivo'),
)
```
## 📦 Despliegue

Compila la aplicación para producción:

```bash
# Para Android
flutter build apk --release

# Para iOS
flutter build ios --release
```
