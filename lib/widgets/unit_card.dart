import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_app/constants/app_colors.dart';

class UnitCard extends StatelessWidget {
  final int index;
  final String unitName;
  final int topicCount;
  final VoidCallback onTap;

  const UnitCard({
    super.key,
    required this.index,
    required this.unitName,
    required this.topicCount,
    required this.onTap,
  });

  Color _getUnitColor(String unitName) {
    switch (unitName.toLowerCase()) {
      case 'addition':
        return AppColors.addition;
      case 'subtraction':
        return AppColors.subtraction;
      case 'multiplication':
        return AppColors.multiplication;
      case 'division':
        return AppColors.division;
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.unitShadow,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26.r,
              backgroundColor: _getUnitColor(unitName),
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  color: AppColors.textLight,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    unitName,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '$topicCount Topics',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.topicText,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
