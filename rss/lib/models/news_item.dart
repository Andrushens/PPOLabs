import 'package:rss/utils/dateparser.dart';
import 'package:webfeed/domain/rss_item.dart';

class NewsItem {
  final String title;
  final String description;
  final String url;
  final String pubDate;
  final String imageUrl;

  NewsItem({
    required this.title,
    required this.description,
    required this.url,
    required this.pubDate,
    required this.imageUrl,
  });

  factory NewsItem.fromRssItem(RssItem item) {
    var link = item.enclosure?.url ??
        item.content?.images.first ??
        item.itunes?.image?.href ??
        ((item.media?.thumbnails?.isNotEmpty ?? false)
            ? item.media?.thumbnails?.first.url ?? ''
            : '');
    return NewsItem(
      title: item.title ?? '',
      description: item.description ?? '',
      url: item.link!,
      pubDate: parseDate(item.pubDate),
      imageUrl: link,
    );
  }
}
