import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tabata_timer/entities/workout.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit(Workout workout) : super(TimerState(workout: workout)) {
    emit(state.copyWith(
      currentPhase: 'Prepare',
      totalCycles: 1 + 2 * workout.cycles * workout.sets,
      currentDuration: workout.prepareTime,
    ));
  }

  Timer? _timer;

  void startTimer() {
    if (state.currentPhaseIndex == state.totalCycles - 1) {
      emit(state.copyWith(currentPhaseIndex: -1));
    }
    emit(state.copyWith(isActive: true));
    _timer = Timer.periodic(
      const Duration(milliseconds: 200),
      (timer) {
        if (state.currentDuration == 0) {
          if (state.currentPhaseIndex == state.totalCycles - 2) {
            emit(state.copyWith(
              currentPhaseIndex: state.currentPhaseIndex + 1,
            ));
            stopTimer();
          } else {
            var newIndex = state.currentPhaseIndex + 1;
            var newDuration = getDurationByIndex(newIndex);
            emit(state.copyWith(
              currentDuration: newDuration,
              currentPhaseIndex: newIndex,
            ));
          }
        } else {
          if (state.currentDuration == 1) {
            var player = AudioCache();
            if (state.currentPhaseIndex == 0) {
              player.play('Pud_move_07_ru.mp3.mpeg');
            } else if (state.currentPhaseIndex == state.totalCycles - 2) {
              player.play('Pud_lasthit_06_ru.mp3.mpeg');
            } else {
              player.play('Pud_move_11_ru.mp3.mpeg');
            }
          }
          emit(state.copyWith(currentDuration: state.currentDuration - 1));
          if (state.currentDuration % 5 == 0) {}
        }
      },
    );
  }

  void stopTimer() {
    _timer?.cancel();
    emit(state.copyWith(isActive: false));
  }

  String getPhaseByIndex(int index) {
    var phase = index == 0
        ? 'Prepare'
        : index == state.totalCycles - 1
            ? 'Finish'
            : index % 2 == 1
                ? 'Work'
                : 'Rest';
    return phase;
  }

  int getDurationByIndex(int index) {
    var duration = index == 0
        ? state.workout.prepareTime
        : index % 2 == 1
            ? state.workout.workTime
            : state.workout.restTime;
    return duration;
  }
}
