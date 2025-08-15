import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EnhancedSearchBarWidget extends StatefulWidget {
  final Function(String) onSearchChanged;
  final VoidCallback onVoiceSearch;

  const EnhancedSearchBarWidget({
    Key? key,
    required this.onSearchChanged,
    required this.onVoiceSearch,
  }) : super(key: key);

  @override
  State<EnhancedSearchBarWidget> createState() =>
      _EnhancedSearchBarWidgetState();
}

class _EnhancedSearchBarWidgetState extends State<EnhancedSearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final text = _searchController.text;
    widget.onSearchChanged(text);
    setState(() {
      _hasText = text.isNotEmpty;
    });
  }

  void _clearSearch() {
    _searchController.clear();
    widget.onSearchChanged('');
    HapticFeedback.lightImpact();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.w),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline,
          width: 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: 'search',
            color: AppTheme.lightTheme.colorScheme.primary,
            size: 7.w,
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: TextField(
              controller: _searchController,
              style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                fontSize: 18.sp, // Larger search text
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
              decoration: InputDecoration(
                hintText: 'Buscar tutoriales...',
                hintStyle: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                  fontSize: 18.sp,
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: widget.onSearchChanged,
            ),
          ),
          if (_hasText)
            GestureDetector(
              onTap: _clearSearch,
              child: Container(
                padding: EdgeInsets.all(1.5.w),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CustomIconWidget(
                  iconName: 'clear',
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  size: 5.w,
                ),
              ),
            ),
          if (!_hasText) ...[
            SizedBox(width: 2.w),
            GestureDetector(
              onTap: widget.onVoiceSearch,
              child: Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.primary
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: AppTheme.lightTheme.colorScheme.primary
                        .withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: CustomIconWidget(
                  iconName: 'mic',
                  color: AppTheme.lightTheme.colorScheme.primary,
                  size: 6.w, // Larger microphone button as requested
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
