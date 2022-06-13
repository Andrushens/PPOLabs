import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static late final Database database;

  DatabaseProvider._();

  static Future<void> init() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'rss_feed.db'),
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE links('
          'link TEXT NOT NULL'
          ');',
        );
      },
      version: 1,
    );
  }

  static Future<List<String>> fetchLinks() async {
    final List<Map<String, dynamic>> maps = await database.query('links');
    var links = List<String>.generate(
      maps.length,
      (i) {
        return maps[i]['link'];
      },
    );
    return links;
  }

  static Future<void> insertLink(String link) async {
    await database.insert(
      'links',
      {'link': link},
    );
  }

  static Future<void> deletelink(String link) async {
    await database.delete(
      'links',
      where: 'link = ?',
      whereArgs: [link],
    );
  }
}
