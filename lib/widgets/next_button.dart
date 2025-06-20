import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_app/constants/app_colors.dart';

class NextButton extends StatelessWidget {
  final bool isLast;
  final bool enabled;
  final VoidCallback onPressed;

  const NextButton({super.key, required this.isLast, required this.enabled, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: enabled ? onPressed : null,
      icon: Icon(isLast ? Icons.check : Icons.arrow_forward),
      label: Text(isLast ? 'Finish' : 'Next', style: TextStyle(fontSize: 16, color: AppColors.textLight)),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        textStyle: TextStyle(fontSize: 15.sp),
      ),
    );
  }
}
