import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:math_app/constants/app_colors.dart';
import 'package:math_app/models/question_model.dart';
import 'package:math_app/models/skill_model.dart';
import 'package:math_app/screens/quiz_settings_screen.dart';
import 'package:math_app/widgets/score_header.dart';
import 'package:math_app/widgets/wrong_answer_card.dart';
import 'package:math_app/providers/quiz_summary_provider.dart';

class QuizSummaryScreen extends StatelessWidget {
  final int total;
  final int correct;
  final List<QuestionModel> wrongQuestions;
  final SkillModel skill;
  final List<QuestionLevel> selectedLevels;

  const QuizSummaryScreen({
    super.key,
    required this.total,
    required this.correct,
    required this.wrongQuestions,
    required this.skill,
    required this.selectedLevels,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizSummaryProvider(
        total: total,
        correct: correct,
        wrongQuestions: wrongQuestions,
        skill: skill,
        selectedLevels: selectedLevels,
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: const Text(
            'Quiz Summary',
            style: TextStyle(fontSize: 16, color: AppColors.textLight),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: Consumer<QuizSummaryProvider>(
            builder: (context, provider, _) {
              return Column(
                children: [
                  ScoreHeader(
                    total: total,
                    correct: correct,
                    percentage: provider.percentage,
                  ),
                  SizedBox(height: 16.h),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Performance by Level:',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        ...provider.levelAccuracy.entries.map(
                          (e) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.h),
                            child: Text(
                              '${e.key.toUpperCase()}: ${e.value.toStringAsFixed(1)}%',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: provider.toggleMistakes,
                          label: Text(
                            provider.showMistakes ? 'Hide Mistakes' : 'Show Mistakes',
                            style: const TextStyle(fontSize: 16, color: AppColors.textLight),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.redAccent,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            textStyle: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => QuizSettingsScreen(skill: skill),
                              ),
                            );
                          },
                          label: const Text(
                            'Retry',
                            style: TextStyle(fontSize: 16, color: AppColors.textLight),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            textStyle: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  if (provider.showMistakes)
                    provider.wrongQuestions.isEmpty
                        ? Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: Colors.green),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.check_circle, color: Colors.green),
                                SizedBox(width: 8.w),
                                Text(
                                  'Great job! No mistakes',
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                              ],
                            ),
                          )
                        : Expanded(
                            child: ListView.separated(
                              itemCount: provider.wrongQuestions.length,
                              separatorBuilder: (_, __) => SizedBox(height: 12.h),
                              itemBuilder: (context, index) {
                                return WrongAnswerCard(
                                  question: provider.wrongQuestions[index],
                                );
                              },
                            ),
                          ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
