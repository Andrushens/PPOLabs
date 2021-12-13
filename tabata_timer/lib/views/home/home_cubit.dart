import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tabata_timer/entities/workout.dart';
import 'package:tabata_timer/services/database/db_provider.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  Future<void> init() async {
    var workouts = await DatabaseProvider.fetchWorkouts();
    emit(state.copyWith(workouts: workouts));
  }

  void addWorkout(Workout? workout) {
    if (workout == null) return;
    var workouts = List<Workout>.from(state.workouts)..add(workout);
    emit(state.copyWith(workouts: workouts));
    DatabaseProvider.insertWorkout(workout);
  }

  void updateWorkout(Workout workout) {
    var workouts = List<Workout>.from(state.workouts);
    var index = workouts.indexOf(
      workouts.where((element) => element.id == workout.id).first,
    );
    workouts[index] = workout;
    emit(state.copyWith(workouts: workouts));
    DatabaseProvider.updateWorkout(workout);
  }

  void deleteWorkouts() {
    var workouts = List<Workout>.from(state.workouts);
    for (var id in state.selectedWorkouts) {
      var toDelete = workouts.where((element) => element.id == id).first;
      workouts.remove(toDelete);
      DatabaseProvider.deleteWorkout(toDelete);
    }
    emit(state.copyWith(
      workouts: workouts,
      selectedWorkouts: [],
    ));
  }

  void deleteAll() {
    for (var workout in state.workouts) {
      DatabaseProvider.deleteWorkout(workout);
    }
    emit(state.copyWith(workouts: []));
  }

  void onWorkoutLongPress(Workout workout) {
    var selected = state.selectedWorkouts;
    var resSelected = <String>[];
    if (selected.contains(workout.id)) {
      resSelected = List<String>.from(selected)..remove(workout.id);
    } else {
      resSelected = List<String>.from(selected)..add(workout.id!);
    }
    emit(state.copyWith(selectedWorkouts: resSelected));
  }

  void onWorkoutTap(Workout workout) {
    var selected = state.selectedWorkouts;
    if (selected.isEmpty) return;
    var resSelected = <String>[];
    if (selected.contains(workout.id)) {
      resSelected = List<String>.from(selected)..remove(workout.id);
    } else {
      resSelected = List<String>.from(selected)..add(workout.id!);
    }
    emit(state.copyWith(selectedWorkouts: resSelected));
  }
}
