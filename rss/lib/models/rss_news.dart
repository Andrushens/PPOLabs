import 'package:uuid/uuid.dart';

class NewsItem {
  String? id;
  final String title;
  final String description;
  final String url;
  final String data;
  final String pubDate;
  final String imageString;

  NewsItem({
    this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.data,
    required this.pubDate,
    required this.imageString,
  }) {
    id = id ?? const Uuid().v1();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'url': url,
      'data': data,
      'createdDate': pubDate,
      'imageString': imageString,
    };
  }
}
