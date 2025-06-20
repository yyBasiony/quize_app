import 'package:flutter/material.dart';
import 'package:math_app/constants/app_colors.dart';
import 'package:math_app/models/choice_model.dart';

class McqOptions extends StatelessWidget {
  final List<ChoiceModel> choices;
  final String? selectedAnswer;
  final String correctAnswer;
  final bool showCorrect;
  final Function(String) onSelect;

  const McqOptions({
    super.key,
    required this.choices,
    required this.selectedAnswer,
    required this.correctAnswer,
    required this.showCorrect,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: choices.map((choice) {
        final isCorrect = choice.text == correctAnswer;
        final isSelected = choice.text == selectedAnswer;

        return Card(
          color: showCorrect
              ? (isCorrect ? AppColors.correctAnswer : isSelected ? AppColors.wrongAnswer : null)
              : null,
          child: RadioListTile<String>(
            title: Text(choice.text),
            value: choice.text,
            groupValue: selectedAnswer,
            onChanged: showCorrect ? null : (value) => onSelect(value!),
          ),
        );
      }).toList(),
    );
  }
}
