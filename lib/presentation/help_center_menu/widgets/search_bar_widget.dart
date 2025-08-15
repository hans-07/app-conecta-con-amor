import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String) onSearchChanged;
  final VoidCallback? onVoiceSearch;

  const SearchBarWidget({
    Key? key,
    required this.onSearchChanged,
    this.onVoiceSearch,
  }) : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchActive = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _searchController.clear();
    widget.onSearchChanged('');
    setState(() {
      _isSearchActive = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: _isSearchActive
                ? AppTheme.lightTheme.colorScheme.primary
                : AppTheme.lightTheme.colorScheme.outline,
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.shadowLight,
              blurRadius: 4.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Search icon
            Padding(
              padding: EdgeInsets.only(left: 4.w),
              child: CustomIconWidget(
                iconName: 'search',
                color: _isSearchActive
                    ? AppTheme.lightTheme.colorScheme.primary
                    : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 6.w,
              ),
            ),

            // Search input field
            Expanded(
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  widget.onSearchChanged(value);
                  setState(() {
                    _isSearchActive = value.isNotEmpty;
                  });
                },
                style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                  fontSize: 16.sp,
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                ),
                decoration: InputDecoration(
                  hintText: 'Buscar tutoriales...',
                  hintStyle: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                    fontSize: 16.sp,
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 3.w,
                    vertical: 2.h,
                  ),
                ),
              ),
            ),

            // Clear button (when search is active)
            if (_isSearchActive) ...[
              GestureDetector(
                onTap: _clearSearch,
                child: Container(
                  padding: EdgeInsets.all(2.w),
                  child: CustomIconWidget(
                    iconName: 'clear',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 5.w,
                  ),
                ),
              ),
            ],

            // Voice search button
            if (widget.onVoiceSearch != null) ...[
              Container(
                margin: EdgeInsets.only(left: 1.w),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: widget.onVoiceSearch,
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      padding: EdgeInsets.all(2.w),
                      child: CustomIconWidget(
                        iconName: 'mic',
                        color: AppTheme.lightTheme.colorScheme.primary,
                        size: 6.w,
                      ),
                    ),
                  ),
                ),
              ),
            ],

            SizedBox(width: 2.w),
          ],
        ),
      ),
    );
  }
}
