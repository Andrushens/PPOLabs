import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tabata_timer/entities/workout.dart';

part 'workout_state.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit(Workout? workout)
      : super(
          WorkoutState(
            workout: workout ?? Workout(name: 'Create workout'),
          ),
        );

  void increasePrepareTime() {
    if (state.workout.prepareTime > 120) return;
    emit(
      state.copyWith(
        workout: state.workout.copyWith(
          prepareTime: state.workout.prepareTime + 1,
        ),
      ),
    );
  }

  void increaseWorkTime() {
    if (state.workout.workTime > 120) return;
    emit(
      state.copyWith(
        workout: state.workout.copyWith(
          workTime: state.workout.workTime + 1,
        ),
      ),
    );
  }

  void increaseRestTime() {
    if (state.workout.restTime > 120) return;
    emit(
      state.copyWith(
        workout: state.workout.copyWith(
          restTime: state.workout.restTime + 1,
        ),
      ),
    );
  }

  void increaseCycles() {
    if (state.workout.cycles > 120) return;
    emit(
      state.copyWith(
        workout: state.workout.copyWith(
          cycles: state.workout.cycles + 1,
        ),
      ),
    );
  }

  void increaseSets() {
    if (state.workout.sets > 120) return;
    emit(
      state.copyWith(
        workout: state.workout.copyWith(
          sets: state.workout.sets + 1,
        ),
      ),
    );
  }

  void decreasePrepareTime() {
    if (state.workout.prepareTime < 6) return;
    emit(
      state.copyWith(
        workout: state.workout.copyWith(
          prepareTime: state.workout.prepareTime - 1,
        ),
      ),
    );
  }

  void decreaseWorkTime() {
    if (state.workout.workTime < 6) return;
    emit(
      state.copyWith(
        workout: state.workout.copyWith(
          workTime: state.workout.workTime - 1,
        ),
      ),
    );
  }

  void decreaseRestTime() {
    if (state.workout.restTime < 6) return;
    emit(
      state.copyWith(
        workout: state.workout.copyWith(
          restTime: state.workout.restTime - 1,
        ),
      ),
    );
  }

  void decreaseCycles() {
    if (state.workout.cycles < 2) return;
    emit(
      state.copyWith(
        workout: state.workout.copyWith(
          cycles: state.workout.cycles - 1,
        ),
      ),
    );
  }

  void decreaseSets() {
    if (state.workout.sets < 2) return;
    emit(
      state.copyWith(
        workout: state.workout.copyWith(
          sets: state.workout.sets - 1,
        ),
      ),
    );
  }

  void updateTitle(String name) {
    if (name.isEmpty) return;
    emit(
      state.copyWith(
        workout: state.workout.copyWith(name: name),
      ),
    );
  }

  void updateColor(Color color) {
    emit(
      state.copyWith(
        workout: state.workout.copyWith(color: color),
      ),
    );
  }
}
