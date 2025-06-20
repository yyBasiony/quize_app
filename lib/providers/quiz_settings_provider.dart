import 'package:flutter/material.dart';
import 'package:math_app/models/question_model.dart';
import 'package:math_app/models/skill_model.dart';

class QuizSettingsProvider extends ChangeNotifier {
  final SkillModel skill;

  QuizSettingsProvider(this.skill);

  final Map<QuestionLevel, bool> selectedLevels = {
    QuestionLevel.easy: false,
    QuestionLevel.medium: false,
    QuestionLevel.hard: false,
  };

  final TextEditingController questionCountController = TextEditingController();

  void toggleLevel(QuestionLevel level, bool selected) {
    selectedLevels[level] = selected;
    notifyListeners();
  }

  void clearSettings() {
    selectedLevels.updateAll((key, _) => false);
    questionCountController.clear();
    notifyListeners();
  }

  List<QuestionModel> getSelectedQuestions() {
    final selectedLevelsList = selectedLevels.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();

    final count = int.tryParse(questionCountController.text.trim());
    final filtered = skill.questions
        .where((q) => selectedLevelsList.contains(q.level))
        .toList()
      ..shuffle();

    return (count != null && count > 0) ? filtered.take(count).toList() : filtered;
  }

  bool isValidSelection() {
    final selectedLevelsList = selectedLevels.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();
    final filtered = skill.questions
        .where((q) => selectedLevelsList.contains(q.level))
        .toList();
    return selectedLevelsList.isNotEmpty && filtered.isNotEmpty;
  }

  @override
  void dispose() {
    questionCountController.dispose();
    super.dispose();
  }
}
