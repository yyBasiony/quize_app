import 'dart:math';
import 'package:math_app/models/question_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('quiz_app.db');
    return _database!;
  }

  static Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  static Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE units (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL
      );
    ''');
    await db.execute('''
      CREATE TABLE skills (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        unit_id INTEGER,
        FOREIGN KEY (unit_id) REFERENCES units(id)
      );
    ''');
    await db.execute('''
      CREATE TABLE questions (
        id INTEGER PRIMARY KEY,
        skill_id INTEGER,
        level TEXT NOT NULL,
        type TEXT NOT NULL,
        question_text TEXT NOT NULL,
        correct_answer TEXT NOT NULL,
        explanation TEXT NOT NULL,
        FOREIGN KEY (skill_id) REFERENCES skills(id)
      );
    ''');
    await db.execute('''
      CREATE TABLE choices (
        id INTEGER PRIMARY KEY,
        question_id INTEGER,
        text TEXT NOT NULL,
        is_correct INTEGER NOT NULL,
        FOREIGN KEY (question_id) REFERENCES questions(id)
      );
    ''');
    await db.execute('''
      CREATE TABLE user_results (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        skill_id INTEGER,
        level TEXT,
        total INTEGER,
        correct INTEGER,
        FOREIGN KEY (skill_id) REFERENCES skills(id)
      );
    ''');
  }

  static Future<void> insertDummyData() async {
    final db = await database;
    final Random rand = Random();

    await db.delete('user_results');
    await db.delete('choices');
    await db.delete('questions');
    await db.delete('skills');
    await db.delete('units');

    final units = [
      {'id': 1, 'name': 'Addition'},
      {'id': 2, 'name': 'Subtraction'},
      {'id': 3, 'name': 'Multiplication'},
      {'id': 4, 'name': 'Division'},
    ];

    int skillId = 1;
    int questionId = 1;

    for (var unit in units) {
      await db.insert('units', unit);
      final unitId = unit['id'] as int;
      final unitName = unit['name'] as String;

      final skills = ['Basic', 'Advanced', 'Word Problems'];
      for (var skillName in skills) {
        await db.insert('skills', {
          'id': skillId,
          'name': '$skillName $unitName',
          'unit_id': unitId,
        });

        // MCQ Questions
        for (int i = 0; i < 20; i++) {
          int a = rand.nextInt(40) + 10;
          int b = rand.nextInt(30) + 1;
          int answer;
          String symbol;

          switch (unitName) {
            case 'Addition':
              answer = a + b;
              symbol = '+';
              break;
            case 'Subtraction':
              answer = a - b;
              symbol = '-';
              break;
            case 'Multiplication':
              answer = a * b;
              symbol = '×';
              break;
            case 'Division':
              answer = a;
              b = b == 0 ? 1 : b;
              symbol = '÷';
              break;
            default:
              answer = 0;
              symbol = '?';
          }

          String level = i < 7 ? 'easy' : (i < 14 ? 'medium' : 'hard');

          await db.insert('questions', {
            'id': questionId,
            'skill_id': skillId,
            'level': level,
            'type': 'mcq',
            'question_text': 'What is $a $symbol $b?',
            'correct_answer': '$answer',
            'explanation': 'The answer is $answer',
          });

          await db.insert('choices', {'question_id': questionId, 'text': '${answer - 1}', 'is_correct': 0});
          await db.insert('choices', {'question_id': questionId, 'text': '$answer', 'is_correct': 1});
          await db.insert('choices', {'question_id': questionId, 'text': '${answer + 1}', 'is_correct': 0});
          await db.insert('choices', {'question_id': questionId, 'text': '${answer + 2}', 'is_correct': 0});
          questionId++;
        }

        for (int i = 0; i < 10; i++) {
          int a = rand.nextInt(90) + 10;
          int b = rand.nextInt(20) + 1;
          int answer;
          String symbol;

          switch (unitName) {
            case 'Addition':
              answer = a + b;
              symbol = '+';
              break;
            case 'Subtraction':
              answer = a - b;
              symbol = '-';
              break;
            case 'Multiplication':
              answer = a * b;
              symbol = '×';
              break;
            case 'Division':
              answer = a;
              b = b == 0 ? 1 : b;
              symbol = '÷';
              break;
            default:
              answer = 0;
              symbol = '?';
          }

          String level = i < 4 ? 'easy' : (i < 7 ? 'medium' : 'hard');

          await db.insert('questions', {
            'id': questionId,
            'skill_id': skillId,
            'level': level,
            'type': 'fill',
            'question_text': 'Solve: $a $symbol $b',
            'correct_answer': '$answer',
            'explanation': 'The answer is $answer',
          });
          questionId++;
        }

        skillId++;
      }
    }
  }

  static Future<List<Map<String, dynamic>>> getUnits() async {
    final db = await database;
    return await db.query('units');
  }

  static Future<List<Map<String, dynamic>>> getSkills(int unitId) async {
    final db = await database;
    return await db.query('skills', where: 'unit_id = ?', whereArgs: [unitId]);
  }

  static Future<List<Map<String, dynamic>>> getQuestions(int skillId) async {
    final db = await database;
    return await db.query('questions', where: 'skill_id = ?', whereArgs: [skillId]);
  }

  static Future<List<Map<String, dynamic>>> getChoices(int questionId) async {
    final db = await database;
    return await db.query('choices', where: 'question_id = ?', whereArgs: [questionId]);
  }

  static Future<void> saveUserResult({
    required int skillId,
    required String level,
    required int total,
    required int correct,
  }) async {
    final db = await database;
    await db.insert(
      'user_results',
      {
        'skill_id': skillId,
        'level': level,
        'total': total,
        'correct': correct,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getResultsBySkill(int skillId) async {
    final db = await database;
    return await db.query('user_results', where: 'skill_id = ?', whereArgs: [skillId]);
  }

  static Future<List<QuestionModel>> getWrongQuestions(int skillId) async {
    return [];
  }
}
