import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import './routes/app_routes.dart';
import './theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, screenType) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.linear(1.0),
        ),
        child: MaterialApp(
          title: 'Senior Launcher',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.light,
          initialRoute: AppRoutes.enhancedMainLauncherHome,
          routes: AppRoutes.routes,
        ),
      );
    });
  }
}
