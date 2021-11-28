import 'package:notes/models/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static late final Database database;

  DatabaseProvider._();

  static Future<void> init() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'notes_app_database.db'),
      onCreate: (db, version) {
        return db.execute('CREATE TABLE notes('
            'id TEXT PRIMARY KEY,'
            'title TEXT,'
            'description TEXT,'
            'createdDate TEXT,'
            'labels TEXT'
            ');');
      },
      version: 1,
    );
  }

  static Future<List<Note>> fetchNotes() async {
    final List<Map<String, dynamic>> maps =
        await database.query('notes', orderBy: 'createdDate');
    return List.generate(maps.length, (i) {
      var labels = maps[i]['labels']?.split('-');
      var createdDate = DateTime.parse(maps[i]['createdDate']);
      return Note(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        createdDate: createdDate,
        labels: labels?[0] != '' ? labels : [],
      );
    }).reversed.toList();
  }

  static Future<void> insertNote(Note note) async {
    await database.insert(
      'notes',
      note.toMap(),
    );
  }

  static Future<void> updateNote(Note note) async {
    await database.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  static Future<void> deleteNote(Note note) async {
    await database.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }
}
