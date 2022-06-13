import 'package:dio/dio.dart';
import 'package:rss/models/news_item.dart';
import 'package:rss/utils/network_status.dart';
import 'package:rss/views/home/cubit/home_cubit.dart';
import 'package:webfeed/webfeed.dart';

class NewsProvider {
  late final Dio dio;

  NewsProvider({required String baseUrl}) {
    dio = Dio(
      BaseOptions(baseUrl: baseUrl),
    );
  }

  Future<void> updateLink(String link) async {
    if (link.isEmpty) return;
    if (!(await isConnected())) {
      throw ErrorType.noConnection;
    }
    var oldUrl = dio.options.baseUrl;
    dio.options.baseUrl = link;
    try {
      await fetchNews();
    } catch (e) {
      print('got updateLink(fetchNews) error: $e');
      dio.options.baseUrl = oldUrl;
      rethrow;
    }
  }

  Future<List<NewsItem>> fetchNews() async {
    if (!(await isConnected())) {
      throw ErrorType.noConnection;
    }
    try {
      var response = await dio.get('');
      var feed = RssFeed.parse(response.data);
      return feed.items!.map((e) => NewsItem.fromRssItem(e)).toList();
    } catch (e) {
      print('got fetchNews error: $e');
      throw ErrorType.incorrectRssLink;
    }
  }
}
