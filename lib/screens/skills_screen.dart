import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_app/constants/app_colors.dart';
import 'package:math_app/models/unit_model.dart';
import 'package:math_app/screens/skill_details_screen.dart';
import 'package:math_app/widgets/skill_card.dart';
import 'package:provider/provider.dart';
import 'package:math_app/providers/skill_provider.dart';

class SkillsScreen extends StatefulWidget {
  final UnitModel unit;

  const SkillsScreen({super.key, required this.unit});

  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<SkillProvider>(context, listen: false)
          .loadSkillsFromUnit(widget.unit);
    });
  }

  @override
  Widget build(BuildContext context) {
    final skills = Provider.of<SkillProvider>(context).skills;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          'Skills in ${widget.unit.name}',
          style: TextStyle(fontSize: 16, color: AppColors.textLight),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: GridView.builder(
          itemCount: skills.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.h,
            crossAxisSpacing: 16.w,
            childAspectRatio: 1.2,
          ),
          itemBuilder: (context, index) {
            final skill = skills[index];
            return SkillCard(
              title: skill.name,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SkillDetailsScreen(skill: skill),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
