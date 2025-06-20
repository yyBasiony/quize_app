import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_app/constants/app_colors.dart';
import 'package:math_app/models/question_model.dart';
import 'package:math_app/models/skill_model.dart';
import 'package:math_app/screens/quiz_summary_screen.dart';
import 'package:math_app/widgets/explanation_box.dart';
import 'package:math_app/widgets/fill_answer.dart';
import 'package:math_app/widgets/mcq_options.dart';
import 'package:math_app/widgets/next_button.dart';
import 'package:math_app/widgets/question_text.dart';
import 'package:provider/provider.dart';
import 'package:math_app/providers/quiz_provider.dart';

class QuizScreen extends StatelessWidget {
  final List<QuestionModel> questions;
  final SkillModel skill;
  final List<QuestionLevel> selectedLevels;

  const QuizScreen({
    super.key,
    required this.questions,
    required this.skill,
    required this.selectedLevels,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizProvider(questions),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: Consumer<QuizProvider>(
            builder: (context, provider, _) => Text(
              'Question ${provider.currentIndex + 1} / ${provider.totalQuestions}',
              style: const TextStyle(fontSize: 16, color: AppColors.textLight),
            ),
          ),
        ),
        body: Consumer<QuizProvider>(
          builder: (context, provider, _) {
            final q = provider.currentQuestion;

            return Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QuestionText(text: q.questionText),
                  SizedBox(height: 24.h),

                  if (q.type == QuestionType.mcq)
                    McqOptions(
                      choices: q.choices!,
                      selectedAnswer: provider.selectedAnswer,
                      correctAnswer: q.correctAnswer,
                      showCorrect: provider.showCorrect,
                      onSelect: provider.checkAnswer,
                    ),

                  if (q.type == QuestionType.fill)
                    FillAnswer(
                      controller: provider.fillController,
                      enabled: !provider.showCorrect,
                      onSubmit: () {
                        final answer = provider.fillController.text.trim();
                        provider.checkAnswer(answer);
                      },
                    ),

                  if (provider.showCorrect)
                    ExplanationBox(text: q.explanation),

                  const Spacer(),

                  NextButton(
                    isLast: provider.isLast,
                    enabled: provider.showCorrect,
                    onPressed: () {
                      if (provider.isLast) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => QuizSummaryScreen(
                              total: provider.totalQuestions,
                              correct: provider.correctCount,
                              wrongQuestions: provider.wrongQuestions,
                              skill: skill,
                              selectedLevels: selectedLevels,
                            ),
                          ),
                        );
                      } else {
                        provider.nextQuestion();
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
