import 'package:flutter/material.dart';
import 'package:math_app/models/skill_model.dart';
import 'package:math_app/models/unit_model.dart';

class SkillProvider extends ChangeNotifier {
  List<SkillModel> _skills = [];

  List<SkillModel> get skills => _skills;

  void loadSkillsFromUnit(UnitModel unit) {
    _skills = unit.skills;
    notifyListeners();
  }
}
