import 'package:flutter/material.dart';
import 'package:math_app/models/skill_model.dart';
import 'package:math_app/models/question_model.dart';
import 'package:math_app/data/database_helper.dart';

class QuizSummaryProvider extends ChangeNotifier {
  final int total;
  final int correct;
  final List<QuestionModel> wrongQuestions;
  final SkillModel skill;
  final List<QuestionLevel> selectedLevels;

  bool showMistakes = false;
  Map<String, double> levelAccuracy = {};

  QuizSummaryProvider({
    required this.total,
    required this.correct,
    required this.wrongQuestions,
    required this.skill,
    required this.selectedLevels,
  }) {
    _saveResults();
    _calculateAccuracy();
  }

  int get percentage => ((correct / total) * 100).round();

  void toggleMistakes() {
    showMistakes = !showMistakes;
    notifyListeners();
  }

  void _calculateAccuracy() {
    Map<String, int> totalMap = {};
    Map<String, int> correctMap = {};

    for (var level in selectedLevels) {
      final levelQuestions =
          skill.questions.where((q) => q.level == level).toList();
      final total = levelQuestions.length;
      final wrong = levelQuestions.where((q) => wrongQuestions.contains(q)).length;
      final correct = total - wrong;

      totalMap[level.name] = total;
      correctMap[level.name] = correct;
    }

    Map<String, double> accuracy = {};
    for (var level in totalMap.keys) {
      final t = totalMap[level]!;
      final c = correctMap[level]!;
      accuracy[level] = t == 0 ? 0 : (c / t) * 100;
    }

    levelAccuracy = accuracy;
  }

  Future<void> _saveResults() async {
    for (var level in selectedLevels) {
      final questionsInLevel =
          skill.questions.where((q) => q.level == level).toList();
      final totalInLevel = questionsInLevel.length;
      final correctInLevel =
          questionsInLevel.where((q) => !wrongQuestions.contains(q)).length;

      await DatabaseHelper.saveUserResult(
        skillId: skill.id,
        level: level.name,
        total: totalInLevel,
        correct: correctInLevel,
      );
    }
  }
}
