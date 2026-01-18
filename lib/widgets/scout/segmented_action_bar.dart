import 'package:flutter/material.dart';
import 'package:futly_scout/constants/app_theme.dart';
import 'package:futly_scout/constants/app_constants.dart';

/// Segmented action bar showing action categories
class SegmentedActionBar extends StatefulWidget {
  final Function(String category) onCategorySelected;
  final String initialCategory;

  const SegmentedActionBar({
    Key? key,
    required this.onCategorySelected,
    this.initialCategory = 'Com Bola',
  }) : super(key: key);

  @override
  State<SegmentedActionBar> createState() => _SegmentedActionBarState();
}

class _SegmentedActionBarState extends State<SegmentedActionBar> {
  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory;
  }

  @override
  Widget build(BuildContext context) {
    final categories = AppConstants.scoutActions.keys.toList();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final category in categories)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: FilterChip(
                label: Text(category),
                selected: selectedCategory == category,
                onSelected: (selected) {
                  setState(() {
                    selectedCategory = category;
                    widget.onCategorySelected(category);
                  });
                },
                backgroundColor: AppTheme.surfaceDark,
                selectedColor: AppTheme.primaryBlue,
                labelStyle: TextStyle(
                  color: selectedCategory == category
                      ? AppTheme.textPrimary
                      : AppTheme.textSecondary,
                  fontWeight: FontWeight.bold,
                ),
                side: BorderSide(
                  color: selectedCategory == category
                      ? AppTheme.primaryBlue
                      : AppTheme.textSecondary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
