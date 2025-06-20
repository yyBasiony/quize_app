import 'package:flutter/material.dart';
import 'package:math_app/models/unit_model.dart';
import 'package:math_app/data/data_service.dart';
import 'package:math_app/data/database_helper.dart';

class UnitProvider extends ChangeNotifier {
  List<UnitModel> _units = [];
  bool _isLoading = false;

  List<UnitModel> get units => _units;
  bool get isLoading => _isLoading;

  Future<void> fetchUnits() async {
    _isLoading = true;
    notifyListeners();

    _units = await DataService.loadAllUnits();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> reloadDummyData() async {
    _isLoading = true;
    notifyListeners();

    await DatabaseHelper.insertDummyData();
    await fetchUnits();
  }
}
