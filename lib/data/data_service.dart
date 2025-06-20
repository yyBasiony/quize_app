import 'package:math_app/models/unit_model.dart';
import 'package:math_app/models/skill_model.dart';
import 'package:math_app/models/question_model.dart';
import 'package:math_app/models/choice_model.dart';
import 'database_helper.dart';

class DataService {
  static Future<List<UnitModel>> loadAllUnits() async {
    final unitRows = await DatabaseHelper.getUnits();
    final List<UnitModel> units = [];

    for (var unit in unitRows) {
      final unitId = unit['id'] as int;

      final skillRows = await DatabaseHelper.getSkills(unitId);
      final List<SkillModel> skills = [];

      for (var skill in skillRows) {
        final skillId = skill['id'] as int;

        final questionRows = await DatabaseHelper.getQuestions(skillId);
        final List<QuestionModel> questions = [];

        for (var q in questionRows) {
          final qId = q['id'] as int;
          final type = q['type'] == 'mcq' ? QuestionType.mcq : QuestionType.fill;
          final level = switch (q['level']) {
            'easy' => QuestionLevel.easy,
            'medium' => QuestionLevel.medium,
            _ => QuestionLevel.hard,
          };

          List<ChoiceModel>? choices;
          if (type == QuestionType.mcq) {
            final choiceRows = await DatabaseHelper.getChoices(qId);
            choices = choiceRows
                .map((c) => ChoiceModel(
                      text: c['text'],
                      isCorrect: c['is_correct'] == 1,
                    ))
                .toList();
          }

          questions.add(QuestionModel(
            id: qId,
            skillId: skillId,
            level: level,
            type: type,
            questionText: q['question_text'],
            correctAnswer: q['correct_answer'],
            explanation: q['explanation'],
            choices: choices,
          ));
        }

        skills.add(SkillModel(
          id: skillId,
          name: skill['name'],
          unitId: unitId,
          questions: questions,
        ));
      }

      units.add(UnitModel(
        id: unitId,
        name: unit['name'],
        skills: skills,
      ));
    }

    return units;
  }
}
