import 'package:flutter/material.dart';

class TimerPhaseContainer extends StatelessWidget {
  const TimerPhaseContainer({
    required this.index,
    required this.phase,
    required this.duration,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final int index;
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
              phase != 'Finish' ? '$index. $phase: $duration' : phase,
              style: const TextStyle(fontSize: 34),
            ),
          ],
        ),
      ),
    );
  }
}
