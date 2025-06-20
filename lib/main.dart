import 'dart:io';
import 'package:flutter/material.dart';
import 'package:math_app/app/app.dart';
import 'package:math_app/providers/skill_provider.dart';
import 'package:provider/provider.dart';
import 'package:math_app/data/database_helper.dart';
import 'package:math_app/providers/unit_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  await DatabaseHelper.insertDummyData();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UnitProvider()),
            ChangeNotifierProvider(create: (_) => SkillProvider()), 

      ],
      child: const MathApp(),
    ),
  );
}

