import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/services/get_circle_color.dart';

class NoteContainer extends StatelessWidget {
  const NoteContainer({
    required this.note,
    required this.isSelected,
    required this.onTap,
    required this.onLongPress,
    Key? key,
  }) : super(key: key);

  final Note note;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

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
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline1,
                ),
                if (note.description.isNotEmpty) ...{
                  const SizedBox(height: 5),
                  Text(
                    note.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                },
                if (note.labels.isNotEmpty) ...{
                  const SizedBox(height: 5),
                  Row(
                    children: List.generate(
                      note.labels.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: CircleAvatar(
                            backgroundColor: getCircleColor(
                              note.labels[index],
                            ),
                            radius: 6,
                          ),
                        );
                      },
                    ),
                  ),
                }
              ],
            ),
          ),
        ),
      ),
    );
  }
}
