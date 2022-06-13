import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EnterLinkDialog extends StatefulWidget {
  const EnterLinkDialog({
    Key? key,
    required this.historyLinks,
  }) : super(key: key);

  final List<String> historyLinks;

  @override
  State<EnterLinkDialog> createState() => _EnterLinkDialogState();
}

class _EnterLinkDialogState extends State<EnterLinkDialog> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.only(
        left: 22,
        top: 40.0,
        right: 22,
        bottom: 20.0,
      ),
      actionsPadding: const EdgeInsets.only(bottom: 20.0),
      contentPadding: const EdgeInsets.symmetric(horizontal: 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      title: const Text(
        'Enter new rss link',
        style: TextStyle(
          fontSize: 26,
        ),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'example.rss',
                    border: InputBorder.none,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(width: 12),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: IconButton(
                  icon: const Icon(
                    Icons.paste_rounded,
                  ),
                  onPressed: () async {
                    controller.text =
                        (await Clipboard.getData(Clipboard.kTextPlain))
                                ?.text
                                ?.trim() ??
                            '';
                  },
                ),
              ),
            ],
          ),
          if (widget.historyLinks.isNotEmpty) ...{
            const SizedBox(height: 8.0),
            Text(
              'recently used links',
              style: TextStyle(
                color: Colors.black.withOpacity(0.4),
              ),
            ),
            const SizedBox(height: 4.0),
            SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: widget.historyLinks.length > 4
                    ? 4 * 33
                    : widget.historyLinks.length * 33,
                child: ListView.builder(
                  itemCount: widget.historyLinks.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        controller.text = widget.historyLinks[index];
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Text(
                          widget.historyLinks[index],
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          },
          Center(
            child: MaterialButton(
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(14),
              child: const Text(
                'Okay',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
          const SizedBox(height: 30.0),
        ],
      ),
    );
  }
}
