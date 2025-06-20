import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_app/constants/app_colors.dart';

class ExplanationBox extends StatelessWidget {
  final String text;

  const ExplanationBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.lightFill,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.unitShadow),
        ),
        child: Text(
          'Explanation: $text',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 14.sp,
            color: AppColors.textDark,
          ),
        ),
      ),
    );
  }
}
