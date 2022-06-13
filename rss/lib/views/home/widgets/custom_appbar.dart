import 'package:flutter/material.dart';
import 'package:rss/utils/network_status.dart';
import 'package:rss/views/home/dialogs/enter_link_dialog.dart';
import 'package:rss/views/home/dialogs/no_connection_dialog.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    Key? key,
    required this.rssController,
    required this.onUpdateRssUrl,
    required this.historyLinks,
  }) : super(key: key);

  final TextEditingController rssController;
  final Function(String link) onUpdateRssUrl;
  final List<String> historyLinks;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  List<String> historyLinks = [];

  @override
  Widget build(BuildContext context) {
    historyLinks = List<String>.from(widget.historyLinks);
    return Column(
      children: [
        Row(
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
                  var rssLink = await showDialog(
                        context: context,
                        builder: (context) {
                          return EnterLinkDialog(
                            historyLinks: historyLinks,
                          );
                        },
                      ) ??
                      '';
                  if (historyLinks.contains(rssLink)) {
                    historyLinks.remove(rssLink);
                  }
                  if (rssLink != null && rssLink.isNotEmpty) {
                    historyLinks.insert(0, rssLink);
                    await widget.onUpdateRssUrl(rssLink);
                  }
                }
              },
              icon: const Icon(
                Icons.link_rounded,
                size: 38,
              ),
            )
          ],
        ),
        const Divider(
          thickness: 2.0,
          color: Colors.black54,
        ),
      ],
    );
  }
}
