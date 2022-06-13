import 'package:flutter/material.dart';
import 'package:rss/models/news_item.dart';
import 'package:rss/utils/network_status.dart';
import 'package:rss/views/home/dialogs/no_connection_dialog.dart';
import 'package:rss/views/home/widgets/custom_webview.dart';
import 'package:rss/views/news_screen/news_screen.dart';

class NewsElement extends StatelessWidget {
  const NewsElement({
    Key? key,
    required this.item,
  }) : super(key: key);

  final NewsItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return NewsScreen(
                item: item,
              );
            },
          ),
        );
      },
      // onTap: () async {
      //   if (await isConnected()) {
      //     Navigator.of(context).push(
      //       MaterialPageRoute(
      //         builder: (context) {
      //           return CustomWebview(item: item);
      //         },
      //       ),
      //     );
      //   } else {
      //     showDialog(
      //       context: context,
      //       builder: (context) {
      //         return const NoConnectionDialog();
      //       },
      //     );
      //   }
      // },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: item.hashCode,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                width: 130,
                height: 110,
                child: Image.network(
                  item.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      color: Colors.red.withOpacity(0.08),
                      child: const Icon(
                        Icons.image_not_supported_rounded,
                        size: 42,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.title,
                  maxLines: 3,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  item.description.trim(),
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  item.pubDate,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
