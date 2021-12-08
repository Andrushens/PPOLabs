import 'package:path/path.dart';
import 'package:rss/models/rss_news.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static late final Database database;

  DatabaseProvider._();

  static Future<void> init() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'rss_app_database.db'),
      onCreate: (db, version) {
        return db.execute('CREATE TABLE news('
            'id TEXT PRIMARY KEY,'
            'title TEXT,'
            'description TEXT,'
            'url TEXT'
            ');');
      },
      version: 1,
    );
  }

  static Future<List<NewsItem>> fetchNews() async {
    final List<Map<String, dynamic>> maps = await database.query('news');
    return List.generate(
      maps.length,
      (i) {
        return NewsItem(
          id: maps[i]['id'],
          title: maps[i]['title'],
          description: maps[i]['description'],
          url: maps[i]['url'],
          data: maps[i]['data'],
          pubDate: maps[i]['createdDate'],
          imageString: maps[i]['imageString'],
        );
      },
    ).reversed.toList();
  }

  static Future<void> updateNews(List<NewsItem> items) async {
    await database.execute('DROP TABLE IF EXISTS news;');
    await database.execute(
      'CREATE TABLE IF NOT EXISTS news('
      'id TEXT PRIMARY KEY,'
      'title TEXT,'
      'description TEXT,'
      'url TEXT,'
      'data TEXT,'
      'createdDate TEXT,'
      'imageString TEXT'
      ');',
    );
    for (var item in items) {
      database.insert('news', item.toMap());
    }
  }
}
