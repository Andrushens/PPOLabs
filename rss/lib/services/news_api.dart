import 'package:dio/dio.dart';
import 'package:rss/models/rss_news.dart';
import 'package:rss/services/db_provider.dart';
import 'package:rss/utils/dateparser.dart';
import 'package:webfeed/webfeed.dart';

class NewsService {
  static String url = 'https://lenta.ru/rss';
  static final Dio dio = Dio();

  static Future<void> checkRss(String rss) async {
    try {
      await dio.get(rss);
    } on DioError catch (_) {
      rethrow;
    }
  }

  static void updateRss(String rss) {
    url = rss;
  }

  static Future<RssFeed> fetchRemoteFeed() async {
    try {
      var response = await dio.get(url);
      var feed = RssFeed.parse(response.data);
      var firstFeeds = feed.items!.sublist(0, 10);
      var news = <NewsItem>[];
      for (var n in firstFeeds) {
        news.add(
          NewsItem(
            title: n.title ?? '',
            description: n.description ?? '',
            url: n.link!,
            data: (await dio.get(n.link!)).data,
            pubDate: parseDate(n.pubDate),
            imageString: n.enclosure?.url ?? '',
          ),
        );
      }
      DatabaseProvider.updateNews(news);
      return feed;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<List<NewsItem>> fetchLocalFeed() async {
    try {
      var news = await DatabaseProvider.fetchNews();
      return news.reversed.toList();
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
