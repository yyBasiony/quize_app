import 'package:flutter/material.dart';
import 'package:math_app/models/question_model.dart';
import 'package:math_app/models/skill_model.dart';
import 'package:math_app/data/database_helper.dart';

class SkillDetailsProvider extends ChangeNotifier {
  final SkillModel skill;

  SkillDetailsProvider(this.skill);

  Map<String, double> _levelAccuracy = {};
  List<QuestionModel> _wrongQuestions = [];
  bool _loading = true;

  Map<String, double> get levelAccuracy => _levelAccuracy;
  List<QuestionModel> get wrongQuestions => _wrongQuestions;
  bool get loading => _loading;

  Future<void> loadResults() async {
    _loading = true;
    notifyListeners();

    final results = await DatabaseHelper.getResultsBySkill(skill.id);
    Map<String, int> totalMap = {};
    Map<String, int> correctMap = {};

    for (var row in results) {
      String level = row['level'];
      totalMap[level] = (totalMap[level] ?? 0) + ((row['total'] ?? 0) as int);
      correctMap[level] = (correctMap[level] ?? 0) + ((row['correct'] ?? 0) as int);
    }

    Map<String, double> accuracy = {};
    for (var level in totalMap.keys) {
      final total = totalMap[level]!;
      final correct = correctMap[level]!;
      accuracy[level] = total == 0 ? 0 : (correct / total) * 100;
    }

    final wrongs = await DatabaseHelper.getWrongQuestions(skill.id);

    _levelAccuracy = accuracy;
    _wrongQuestions = wrongs;
    _loading = false;
    notifyListeners();
  }
}
