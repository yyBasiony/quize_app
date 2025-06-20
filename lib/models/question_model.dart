import 'package:math_app/models/choice_model.dart';

enum QuestionType { mcq, fill }
enum QuestionLevel { easy, medium, hard }

class QuestionModel {
  final int id;
  final int skillId;
  final QuestionLevel level;
  final QuestionType type;
  final String questionText;
  final String correctAnswer;
  final String explanation;
  final List<ChoiceModel>? choices;

  String? userAnswer;

  QuestionModel({
    required this.id,
    required this.skillId,
    required this.level,
    required this.type,
    required this.questionText,
    required this.correctAnswer,
    required this.explanation,
    this.choices,
    this.userAnswer, 
  });
}
