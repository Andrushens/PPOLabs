import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rss/models/rss_news.dart';
import 'package:rss/services/news_api.dart';
import 'package:rss/utils/dateparser.dart';
import 'package:rss/utils/network_status.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/webfeed.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final rssController = TextEditingController();

  @override
  void initState() {
    super.initState();
    rssController.text = NewsService.url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Latest News',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (!(await isConnected())) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const NoConnectionDialog();
                            },
                          );
                        } else {
                          await showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        controller: rssController,
                                        style: const TextStyle(fontSize: 18),
                                        decoration:
                                            const InputDecoration.collapsed(
                                          hintText: 'Enter new rss',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                          try {
                            await NewsService.checkRss(rssController.text);
                            NewsService.updateRss(rssController.text);
                          } on DioError catch (_) {
                            rssController.text = NewsService.url;
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  content: Text(
                                    'Incorrect rss path',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              },
                            );
                          }
                        }
                      },
                      icon: const Icon(Icons.rss_feed),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                    future: isConnected(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var connected = snapshot.data as bool;
                        return RefreshIndicator(
                          onRefresh: () async {
                            connected = await isConnected();
                            setState(() {});
                          },
                          child: !connected
                              ? const OfflineFeed()
                              : FutureBuilder<RssFeed>(
                                  future: NewsService.fetchRemoteFeed(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError || snapshot.hasData) {
                                      var news = snapshot.hasData
                                          ? snapshot.data?.items
                                              as List<RssItem>
                                          : [];
                                      return RefreshIndicator(
                                        onRefresh: () async {
                                          if (await isConnected()) {
                                            news = (await NewsService
                                                    .fetchRemoteFeed())
                                                .items!;
                                            setState(() {});
                                          } else {
                                            await showDialog(
                                              context: context,
                                              builder: (context) {
                                                return const NoConnectionDialog();
                                              },
                                            );
                                          }
                                        },
                                        child: Center(
                                          child: ListView.builder(
                                            itemCount: news.length,
                                            itemBuilder: (context, index) {
                                              var current = news[index];
                                              return Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8),
                                                child: OnlineTileElement(
                                                    current: current),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    }
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OfflineFeed extends StatelessWidget {
  const OfflineFeed({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewsItem>>(
      future: NewsService.fetchLocalFeed(),
      builder: (context, snapshot) {
        if (snapshot.hasError || snapshot.hasData) {
          var news = snapshot.hasData ? snapshot.data as List<NewsItem> : [];
          return Center(
            child: ListView.builder(
              itemCount: news.length,
              itemBuilder: (context, index) {
                var current = news[index];
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: OfflineTileElement(current: current),
                );
              },
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class NoConnectionDialog extends StatelessWidget {
  const NoConnectionDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      content: Text(
        'No internet connection.',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class OnlineTileElement extends StatelessWidget {
  const OnlineTileElement({
    Key? key,
    required this.current,
  }) : super(key: key);

  final RssItem current;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (await isConnected()) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.grey[800],
                    leading: const BackButton(),
                  ),
                  body: WebView(
                    initialUrl: current.link,
                    navigationDelegate: (NavigationRequest request) {
                      var link = Uri.parse(current.link!);
                      if (request.url.contains(
                        link.host,
                      )) {
                        print('allow');
                        return NavigationDecision.navigate;
                      }
                      print('prevent');
                      return NavigationDecision.prevent;
                    },
                  ),
                );
              },
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return const NoConnectionDialog();
            },
          );
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              if (current.enclosure != null && current.enclosure!.url != null)
                SizedBox(
                  width: 130,
                  height: 110,
                  child: Image.network(
                    current.enclosure!.url!,
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  current.title!,
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  current.description!.trim(),
                  maxLines: 3,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  parseDate(current.pubDate),
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

class OfflineTileElement extends StatelessWidget {
  OfflineTileElement({
    Key? key,
    required this.current,
  }) : super(key: key);

  final NewsItem current;
  late final WebViewController webController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.grey[800],
                  leading: const BackButton(),
                ),
                body: WebView(
                  onWebViewCreated: (controller) async {
                    webController = controller;
                    webController.loadUrl(
                      Uri.dataFromString(
                        current.data,
                        mimeType: 'text/html',
                        encoding: Encoding.getByName('utf-8'),
                      ).toString(),
                    );
                  },
                  navigationDelegate: (NavigationRequest request) {
                    return NavigationDecision.prevent;
                  },
                ),
              );
            },
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            current.title,
            maxLines: 2,
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Text(
            current.description.trim(),
            maxLines: 3,
            style:
                Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Text(
            current.pubDate,
            style:
                Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
