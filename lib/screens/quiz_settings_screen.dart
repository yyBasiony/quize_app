import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_app/constants/app_colors.dart';
import 'package:math_app/models/skill_model.dart';
import 'package:math_app/screens/quiz_screen.dart';
import 'package:math_app/widgets/level_selector.dart';
import 'package:provider/provider.dart';
import 'package:math_app/providers/quiz_settings_provider.dart';

class QuizSettingsScreen extends StatelessWidget {
  final SkillModel skill;

  const QuizSettingsScreen({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizSettingsProvider(skill),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: const Text(
            'Quiz Settings',
            style: TextStyle(fontSize: 16, color: AppColors.textLight),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: Consumer<QuizSettingsProvider>(
            builder: (context, provider, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🎯 Select Difficulty Level',
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12.h),
                  LevelSelector(
                    selectedLevels: provider.selectedLevels,
                    onChanged: provider.toggleLevel,
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    ' Number of Questions (optional)',
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.h),
                  TextField(
                    controller: provider.questionCountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'e.g. 10 — Leave empty to use all questions',
                      prefixIcon: const Icon(Icons.format_list_numbered),
                      filled: true,
                      fillColor: AppColors.lightFill,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: provider.clearSettings,
                          label: const Text('Clear'),
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
                      SizedBox(width: 16.w),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (!provider.isValidSelection()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please select levels and make sure questions exist',
                                  ),
                                ),
                              );
                              return;
                            }

                            final selectedLevels = provider.selectedLevels.entries
                                .where((e) => e.value)
                                .map((e) => e.key)
                                .toList();

                            final selectedQuestions = provider.getSelectedQuestions();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => QuizScreen(
                                  questions: selectedQuestions,
                                  skill: skill,
                                  selectedLevels: selectedLevels,
                                ),
                              ),
                            );
                          },
                          label: const Text(
                            'Start',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.textLight,
                            ),
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
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
