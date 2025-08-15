import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/app_column_widget.dart';
import './widgets/emergency_section_widget.dart';
import './widgets/header_section_widget.dart';

class EnhancedMainLauncherHome extends StatefulWidget {
  const EnhancedMainLauncherHome({Key? key}) : super(key: key);

  @override
  State<EnhancedMainLauncherHome> createState() =>
      _EnhancedMainLauncherHomeState();
}

class _EnhancedMainLauncherHomeState extends State<EnhancedMainLauncherHome> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _bottomNavItems = [
    {
      'icon': 'home',
      'label': 'Inicio',
      'route': '/enhanced-main-launcher-home',
    },
    {
      'icon': 'help',
      'label': 'Ayuda',
      'route': '/help-center-menu',
    },
    {
      'icon': 'settings',
      'label': 'Ajustes',
      'route': '/settings',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const HeaderSectionWidget(),
              SizedBox(height: 2.h),
              const EmergencySectionWidget(),
              SizedBox(height: 3.h),
              const AppColumnWidget(),
              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: AppTheme.lightTheme.colorScheme.outline,
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: 10.h,
          padding: EdgeInsets.symmetric(vertical: 1.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _bottomNavItems.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isSelected = _currentIndex == index;

              return GestureDetector(
                onTap: () => _onBottomNavTap(index, item['route'] as String),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                    vertical: 1.h,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.lightTheme.colorScheme.primary
                            .withValues(alpha: 0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: item['icon'] as String,
                        color: isSelected
                            ? AppTheme.lightTheme.colorScheme.primary
                            : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        size: 28,
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        item['label'] as String,
                        style:
                            AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                          color: isSelected
                              ? AppTheme.lightTheme.colorScheme.primary
                              : AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  void _onBottomNavTap(int index, String route) {
    HapticFeedback.lightImpact();

    setState(() {
      _currentIndex = index;
    });

    if (index != 0) {
      Navigator.pushNamed(context, route);
    }
  }
}
