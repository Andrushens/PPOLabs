part of 'workout_cubit.dart';

class WorkoutState extends Equatable {
  final Workout workout;

  const WorkoutState({
    required this.workout,
  });

  WorkoutState copyWith({
    Workout? workout,
  }) {
    return WorkoutState(
      workout: workout ?? this.workout,
    );
  }

  @override
  List<Object> get props {
    return [workout];
  }
}
