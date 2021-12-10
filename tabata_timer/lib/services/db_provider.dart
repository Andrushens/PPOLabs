import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tabata_timer/entities/workout.dart';

class DatabaseProvider {
  static late final Database database;

  DatabaseProvider._();

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    database = await openDatabase(
      join(await getDatabasesPath(), 'tabata_app_database.db'),
      onCreate: (db, version) {
        return db.execute('CREATE TABLE workouts('
            'id TEXT PRIMARY KEY,'
            'name TEXT,'
            'prepareTime INTEGER,'
            'workTime INTEGER,'
            'restTime INTEGER,'
            'cycles INTEGER,'
            'color INTEGER'
            ');');
      },
      version: 1,
    );
  }

  static Future<List<Workout>> fetchWorkouts() async {
    final List<Map<String, dynamic>> maps = await database.query('workouts');
    return List.generate(maps.length, (i) {
      return Workout(
        id: maps[i]['id'],
        name: maps[i]['name'],
        prepareTime: maps[i]['prepareTime'],
        workTime: maps[i]['workTime'],
        restTime: maps[i]['restTime'],
        cycles: maps[i]['cycles'],
        color: Color(maps[i]['color']),
      );
    }).reversed.toList();
  }

  static Future<void> insertWorkout(Workout workout) async {
    await database.insert(
      'workouts',
      workout.toMap(),
    );
  }

  static Future<void> updateWorkout(Workout workout) async {
    await database.update(
      'workouts',
      workout.toMap(),
      where: 'id = ?',
      whereArgs: [workout.id],
    );
  }

  static Future<void> deleteWorkout(Workout workout) async {
    await database.delete(
      'workouts',
      where: 'id = ?',
      whereArgs: [workout.id],
    );
  }
}
