import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_app/constants/app_colors.dart';

class ScoreHeader extends StatelessWidget {
  final int total;
  final int correct;
  final int percentage;

  const ScoreHeader({
    super.key,
    required this.total,
    required this.correct,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32.r,
            backgroundColor: AppColors.primary,
            child: Text(
              '$percentage%',
              style: TextStyle(
                color: AppColors.textLight,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Score',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                '$correct out of $total correct',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: AppColors.topicText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
