import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionText extends StatelessWidget {
  final String text;

  const QuestionText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
    );
  }
}
