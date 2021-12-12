import 'package:flutter/material.dart';

class TimerPhaseContainer extends StatelessWidget {
  const TimerPhaseContainer({
    required this.index,
    required this.isActive,
    required this.phase,
    required this.duration,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final int index;
  final bool isActive;
  final String phase;
  final int duration;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              phase != 'Finish' ? '${index + 1}. $phase: $duration' : phase,
              style: TextStyle(
                fontSize: 34,
                color: isActive
                    ? Colors.red
                    : Theme.of(context).textTheme.bodyText1!.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
