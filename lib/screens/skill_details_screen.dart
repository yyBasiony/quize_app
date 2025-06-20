import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_app/constants/app_colors.dart';
import 'package:math_app/models/skill_model.dart';
import 'package:math_app/screens/quiz_settings_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:math_app/providers/skill_details_provider.dart';

class SkillDetailsScreen extends StatelessWidget {
  final SkillModel skill;

  const SkillDetailsScreen({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SkillDetailsProvider(skill)..loadResults(),
      child: Scaffold(
        appBar: AppBar(backgroundColor: AppColors.primary, title: Text(skill.name, style: const TextStyle(fontSize: 16, color: AppColors.textLight))),
        body: Consumer<SkillDetailsProvider>(
          builder: (context, provider, _) {
            if (provider.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/quize.json', height: 200.h),
                      SizedBox(height: 24.h),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => QuizSettingsScreen(skill: skill)));
                        },
                        label: const Text('Create Quiz', style: TextStyle(fontSize: 16, color: AppColors.textLight)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
                          textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
