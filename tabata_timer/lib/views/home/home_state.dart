part of 'home_cubit.dart';

class HomeState extends Equatable {
  final List<Workout> workouts;
  final List<String> selectedWorkouts;

  const HomeState({
    this.workouts = const [],
    this.selectedWorkouts = const [],
  });

  HomeState copyWith({
    List<Workout>? workouts,
    List<String>? selectedWorkouts,
  }) {
    return HomeState(
      workouts: workouts ?? this.workouts,
      selectedWorkouts: selectedWorkouts ?? this.selectedWorkouts,
    );
  }

  @override
  List<Object> get props {
    return [
      workouts,
      selectedWorkouts,
    ];
  }
}
