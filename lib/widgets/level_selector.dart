import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_app/constants/app_colors.dart';
import 'package:math_app/models/question_model.dart';

class LevelSelector extends StatelessWidget {
  final Map<QuestionLevel, bool> selectedLevels;
  final Function(QuestionLevel level, bool selected) onChanged;

  const LevelSelector({
    super.key,
    required this.selectedLevels,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      children: selectedLevels.keys.map((level) {
        final isSelected = selectedLevels[level]!;
        return ChoiceChip(
          label: Text(level.name.toUpperCase()),
          selected: isSelected,
          selectedColor: AppColors.primary,
          labelStyle: TextStyle(
            color: isSelected ? AppColors.textLight : AppColors.textDark,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
          onSelected: (value) => onChanged(level, value),
        );
      }).toList(),
    );
  }
}
