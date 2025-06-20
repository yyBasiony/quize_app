import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_app/constants/app_colors.dart';
import '../models/question_model.dart';

class WrongAnswerCard extends StatelessWidget {
  final QuestionModel question;

  const WrongAnswerCard({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.questionText,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10.h),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Your Answer: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                  ),
                  TextSpan(
                    text: question.userAnswer ?? 'N/A',
                    style: TextStyle(color: AppColors.subtraction, fontSize: 14.sp),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.h),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Correct Answer: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                  ),
                  TextSpan(
                    text: question.correctAnswer,
                    style: TextStyle(color: AppColors.addition, fontSize: 14.sp),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Explanation: ${question.explanation}',
              style: TextStyle(fontSize: 13.5.sp, fontStyle: FontStyle.italic, color: AppColors.topicSubText),
            ),
          ],
        ),
      ),
    );
  }
}
