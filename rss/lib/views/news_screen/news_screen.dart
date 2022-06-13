import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rss/models/news_item.dart';
import 'package:rss/utils/network_status.dart';
import 'package:rss/views/home/dialogs/no_connection_dialog.dart';
import 'package:rss/views/home/dialogs/smth_went_wrong_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({
    required this.item,
    Key? key,
  }) : super(key: key);

  final NewsItem item;

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: TextButton(
                child: const Text(
                  'Go back',
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                onPressed: Navigator.of(context).pop,
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              color: Colors.black54,
              height: 2.0,
            ),
          ),
          preferredSize: const Size.fromHeight(4.0),
        ),
        elevation: 0.0,
      ),
      body: LayoutBuilder(
        builder: ((context, constraints) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 16.0,
              ),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight * 0.95,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.item.title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontSize: 26),
                          textAlign: TextAlign.center,
                        ),
                        if (widget.item.imageUrl.isNotEmpty) ...{
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () async {
                              var url = widget.item.url;
                              if (await launch(url)) {
                              } else {
                                if (!(await isConnected())) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const NoConnectionDialog();
                                    },
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const SmthWentWrongDialog();
                                    },
                                  );
                                }
                              }
                            },
                            child: Hero(
                              tag: widget.item.hashCode,
                              child: ClipRRect(
                                child: Image.network(
                                  widget.item.imageUrl,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container();
                                  },
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        },
                        const SizedBox(height: 6),
                        Text(
                          widget.item.pubDate,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '        ${widget.item.description.trim()}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 16),
                          textAlign: TextAlign.justify,
                        ),
                        const Spacer(),
                        const Divider(
                          thickness: 2.0,
                          color: Colors.black54,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Original post',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue[900],
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                var url = widget.item.url;
                                if (await launch(url)) {
                                } else {
                                  if (!(await isConnected())) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const NoConnectionDialog();
                                      },
                                    );
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const SmthWentWrongDialog();
                                      },
                                    );
                                  }
                                }
                              },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
