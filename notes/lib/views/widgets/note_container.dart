import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';

class NoteContainer extends StatelessWidget {
  const NoteContainer({
    required this.note,
    required this.isSelected,
    required this.onTap,
    required this.onLongPress,
    this.tags = const ['pudge', 'stas', 'gold', 'genyi'],
    Key? key,
  }) : super(key: key);

  final Note note;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: note.id.toString(),
      child: GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFFFFDAC7)
                : const Color(0xFFFFDAC7).withOpacity(0.2),
            border: Border.all(
              color: const Color.fromRGBO(0, 0, 0, 0.3),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(height: 5),
                Text(
                  note.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
