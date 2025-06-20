import 'package:flutter/material.dart';
import 'package:math_app/models/question_model.dart';

class QuizProvider extends ChangeNotifier {
  final List<QuestionModel> questions;

  QuizProvider(this.questions) {
    _currentQuestion = questions[_currentIndex];
  }

  int _currentIndex = 0;
  late QuestionModel _currentQuestion;
  String? _selectedAnswer;
  bool _showCorrect = false;
  int _correctCount = 0;
  final List<QuestionModel> _wrongQuestions = [];
  final TextEditingController fillController = TextEditingController();

  int get currentIndex => _currentIndex;
  QuestionModel get currentQuestion => _currentQuestion;
  String? get selectedAnswer => _selectedAnswer;
  bool get showCorrect => _showCorrect;
  int get correctCount => _correctCount;
  List<QuestionModel> get wrongQuestions => _wrongQuestions;
  int get totalQuestions => questions.length;

  void checkAnswer(String answer) {
    final userAns = answer.trim();
    _selectedAnswer = userAns;
    _showCorrect = true;
    _currentQuestion.userAnswer = userAns;

    if (userAns.toLowerCase() ==
        _currentQuestion.correctAnswer.trim().toLowerCase()) {
      _correctCount++;
    } else {
      _wrongQuestions.add(_currentQuestion);
    }
    notifyListeners();
  }

  bool get isLast => _currentIndex == questions.length - 1;

  void nextQuestion() {
    if (!isLast) {
      _currentIndex++;
      _currentQuestion = questions[_currentIndex];
      _selectedAnswer = null;
      _showCorrect = false;
      fillController.clear();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    fillController.dispose();
    super.dispose();
  }
}
