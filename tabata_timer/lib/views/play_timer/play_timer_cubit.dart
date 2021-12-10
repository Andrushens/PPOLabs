import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'play_timer_state.dart';

class PlayTimerCubit extends Cubit<PlayTimerState> {
  PlayTimerCubit() : super(PlayTimerInitial());
}
