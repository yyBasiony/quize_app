import 'package:math_app/models/skill_model.dart';

class UnitModel {
  final int id;
  final String name;
  final List<SkillModel> skills;

  UnitModel({
    required this.id,
    required this.name,
    required this.skills,
  });
}
