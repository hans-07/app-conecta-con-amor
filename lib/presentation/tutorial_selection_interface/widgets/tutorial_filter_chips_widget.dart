import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class TutorialFilterChipsWidget extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;

  const TutorialFilterChipsWidget({
    Key? key,
    required this.selectedFilter,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> filters = [
      {'key': 'todos', 'label': 'Todos'},
      {'key': 'basico', 'label': 'Básico'},
      {'key': 'intermedio', 'label': 'Intermedio'},
      {'key': 'completados', 'label': 'Completados'},
      {'key': 'favoritos', 'label': 'Favoritos'},
    ];

    return Container(
      height: 6.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        itemCount: filters.length,
        separatorBuilder: (context, index) => SizedBox(width: 2.w),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = selectedFilter == filter['key'];

          return FilterChip(
            label: Text(
              filter['label']!,
              style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                color: isSelected
                    ? AppTheme.lightTheme.colorScheme.onPrimary
                    : AppTheme.textSecondary,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
            selected: isSelected,
            onSelected: (selected) {
              if (selected) {
                onFilterChanged(filter['key']!);
              }
            },
            backgroundColor: AppTheme.lightTheme.colorScheme.surface,
            selectedColor: AppTheme.phoneAction,
            checkmarkColor: AppTheme.lightTheme.colorScheme.onPrimary,
            side: BorderSide(
              color: isSelected
                  ? AppTheme.phoneAction
                  : AppTheme.lightTheme.colorScheme.outline,
              width: 2,
            ),
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          );
        },
      ),
    );
  }
}
