import 'package:flutter/material.dart';
import 'package:tabata_timer/entities/workout.dart';

class WorkoutContainer extends StatelessWidget {
  const WorkoutContainer({
    required this.workout,
    required this.onButtonPressed,
    required this.onLongPress,
    required this.onTap,
    required this.isSelected,
    Key? key,
  }) : super(key: key);

  final Workout workout;
  final bool isSelected;
  final VoidCallback onButtonPressed;
  final Function(Workout) onLongPress;
  final Function(Workout) onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () {
        onLongPress(workout);
      },
      onTap: () {
        onTap(workout);
      },
      leading: Text(
        workout.name,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      trailing: IconButton(
        onPressed: onButtonPressed,
        icon: const Icon(
          Icons.play_arrow_rounded,
          size: 36,
        ),
      ),
      tileColor: isSelected
          ? workout.color.withOpacity(0.6)
          : workout.color.withOpacity(0.2),
    );
  }
}
