part of 'workout_cubit.dart';

class WorkoutState extends Equatable {
  Workout? workout;

  WorkoutState({
    this.workout,
  }) {
    workout ??= Workout(name: 'My Workout');
  }

  WorkoutState copyWith({
    Workout? workout,
  }) {
    return WorkoutState(
      workout: workout ?? this.workout,
    );
  }

  @override
  List<Object> get props {
    return [
      if (workout != null)
        {
          workout!,
        },
    ];
  }
}
