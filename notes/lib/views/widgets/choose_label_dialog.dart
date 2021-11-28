import 'package:flutter/material.dart';
import 'package:notes/services/get_circle_color.dart';

class ChooseLabeLdialog extends StatefulWidget {
  ChooseLabeLdialog({
    required this.possibleLabels,
    required this.currentLabels,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  final Function(int idx, bool value) onChanged;
  final List<String> possibleLabels;
  List<String> currentLabels;

  @override
  State<ChooseLabeLdialog> createState() => _ChooseLabeLdialogState();
}

class _ChooseLabeLdialogState extends State<ChooseLabeLdialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          'Choose Labels',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          widget.possibleLabels.length,
          (index) => CheckboxListTile(
            activeColor: Colors.brown[500],
            title: Row(
              children: [
                CircleAvatar(
                  backgroundColor: getCircleColor(
                    widget.possibleLabels[index],
                  ),
                  radius: 6,
                ),
                const SizedBox(width: 12),
                Text(widget.possibleLabels[index]),
              ],
            ),
            controlAffinity: ListTileControlAffinity.leading,
            value: widget.currentLabels.contains(widget.possibleLabels[index]),
            onChanged: (value) {
              _updateLabel(index, value!);
              widget.onChanged(index, value);
            },
          ),
        ),
      ),
    );
  }

  void _updateLabel(int index, bool value) {
    var current = List<String>.from(widget.currentLabels);
    if (value) {
      setState(() {
        current.add(widget.possibleLabels[index]);
      });
    } else {
      setState(() {
        current.remove(widget.possibleLabels[index]);
      });
    }
    widget.currentLabels = current;
  }
}
