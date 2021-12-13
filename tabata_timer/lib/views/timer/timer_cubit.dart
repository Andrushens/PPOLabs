import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tabata_timer/entities/workout.dart';
import 'package:tabata_timer/services/background_timer.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit(Workout workout) : super(TimerState(workout: workout)) {
    emit(state.copyWith(
      currentPhase: 'Prepare',
      totalCycles: 1 + 2 * workout.cycles * workout.sets,
      currentDuration: workout.prepareTime,
    ));
    startTimerService();
    updateBackgroundTimer('Prepare', state.workout.prepareTime);
  }

  Timer? _timer;

  void startTimer() {
    if (state.currentPhaseIndex == state.totalCycles - 1) {
      emit(state.copyWith(currentPhaseIndex: -1));
    }
    emit(state.copyWith(isActive: true));
    _timer = Timer.periodic(
      const Duration(milliseconds: 1000),
      (timer) {
        if (state.currentDuration == 0) {
          if (state.currentPhaseIndex == state.totalCycles - 2) {
            emit(state.copyWith(
              currentPhaseIndex: state.currentPhaseIndex + 1,
              currentPhase: 'Finish',
            ));
            stopTimer();
          } else {
            var newIndex = state.currentPhaseIndex + 1;
            var newPhase = getPhaseByIndex(newIndex);
            var newDuration = getDurationByIndex(newIndex);
            emit(state.copyWith(
              currentDuration: newDuration,
              currentPhaseIndex: newIndex,
              currentPhase: newPhase,
            ));
            updateBackgroundTimer(
              state.currentPhaseString,
              state.currentDuration,
            );
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
          updateBackgroundTimer(
            state.currentPhaseString,
            state.currentDuration,
          );
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
        : index == state.totalCycles - 1
            ? 0
            : index % 2 == 1
                ? state.workout.workTime
                : state.workout.restTime;
    return duration;
  }

  void skipNextPhase() {
    changePhase(state.currentPhaseIndex + 1);
  }

  void skipPreviousPhase() {
    changePhase(state.currentPhaseIndex - 1);
  }

  void changePhase(index) {
    if (index == -1) {
      emit(state.copyWith(currentDuration: state.workout.prepareTime));
      return;
    }
    if (index == state.totalCycles - 1) return;
    var newPhase = getPhaseByIndex(index);
    var newDuration = getDurationByIndex(index);
    emit(state.copyWith(
      currentDuration: newDuration,
      currentPhaseIndex: index,
      currentPhase: newPhase,
    ));
    updateBackgroundTimer(state.currentPhaseString, state.currentDuration);
  }
}
