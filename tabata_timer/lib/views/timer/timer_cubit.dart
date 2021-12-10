import 'dart:async';

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
    emit(state.copyWith(isActive: true));
    _timer = Timer.periodic(
      const Duration(milliseconds: 400),
      (timer) {
        if (state.currentDuration == 0) {
          stopTimer();
        } else {
          emit(state.copyWith(currentDuration: state.currentDuration - 1));
        }
      },
    );
  }

  void stopTimer() {
    _timer?.cancel();
    emit(state.copyWith(isActive: false));
  }
}
