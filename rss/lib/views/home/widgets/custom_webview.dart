import 'package:flutter/material.dart';
import 'package:rss/models/news_item.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebview extends StatefulWidget {
  const CustomWebview({
    Key? key,
    required this.item,
  }) : super(key: key);

  final NewsItem item;

  @override
  State<CustomWebview> createState() => _CustomWebviewState();
}

class _CustomWebviewState extends State<CustomWebview> {
  var isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        leading: const BackButton(),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.item.url,
            javascriptMode: JavascriptMode.unrestricted,
            // navigationDelegate: (NavigationRequest request) {
            //   var link = Uri.parse(widget.item.url);
            //   if (request.url.contains(link.host)) {
            //     return NavigationDecision.navigate;
            //   }
            //   return NavigationDecision.prevent;
            // },
            onPageFinished: (_) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          if (isLoading) ...{
            const Center(
              child: CircularProgressIndicator(),
            ),
          }
        ],
      ),
    );
  }
}
