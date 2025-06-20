import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:math_app/constants/app_colors.dart';
import 'package:math_app/screens/skills_screen.dart';
import 'package:math_app/widgets/unit_card.dart';
import 'package:math_app/providers/unit_provider.dart';

class UnitsScreen extends StatefulWidget {
  const UnitsScreen({super.key});

  @override
  State<UnitsScreen> createState() => _UnitsScreenState();
}

class _UnitsScreenState extends State<UnitsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<UnitProvider>(context, listen: false).fetchUnits());
  }

  @override
  Widget build(BuildContext context) {
    final unitProvider = Provider.of<UnitProvider>(context);
    final units = unitProvider.units;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '📚 Math Units',
          style: TextStyle(fontSize: 16, color: AppColors.textLight),
        ),
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await unitProvider.reloadDummyData();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Dummy data reloaded')),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: unitProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : units.isEmpty
                ? const Center(child: Text('No units found. Please add data.'))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Choose a math unit to start learning ',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Expanded(
                        child: ListView.separated(
                          itemCount: units.length,
                          separatorBuilder: (_, __) => SizedBox(height: 12.h),
                          itemBuilder: (context, index) {
                            final unit = units[index];
                            return UnitCard(
                              index: index,
                              unitName: unit.name,
                              topicCount: unit.skills.length,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => SkillsScreen(unit: unit),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
