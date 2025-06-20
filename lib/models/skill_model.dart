import 'package:math_app/models/question_model.dart';

class SkillModel {
  final int id;
  final String name;
  final int unitId;
  final List<QuestionModel> questions;

  SkillModel({
    required this.id,
    required this.name,
    required this.unitId,
    required this.questions,
  });
}
