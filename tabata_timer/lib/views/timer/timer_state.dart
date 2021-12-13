part of 'timer_cubit.dart';

class TimerState extends Equatable {
  final Workout workout;
  final bool isActive;
  final String currentPhaseString;
  final int currentPhaseIndex;
  final int currentDuration;
  final int totalCycles;

  const TimerState({
    required this.workout,
    this.isActive = false,
    this.currentPhaseString = '',
    this.currentPhaseIndex = 0,
    this.currentDuration = 0,
    this.totalCycles = 0,
  });

  TimerState copyWith({
    bool? isActive,
    String? currentPhaseString,
    int? currentPhaseIndex,
    int? currentDuration,
    int? totalCycles,
  }) {
    return TimerState(
      workout: workout,
      isActive: isActive ?? this.isActive,
      currentPhaseString: currentPhaseString ?? this.currentPhaseString,
      currentPhaseIndex: currentPhaseIndex ?? this.currentPhaseIndex,
      currentDuration: currentDuration ?? this.currentDuration,
      totalCycles: totalCycles ?? this.totalCycles,
    );
  }

  @override
  List<Object> get props {
    return [
      workout,
      isActive,
      currentPhaseString,
      currentPhaseIndex,
      currentDuration,
      totalCycles,
    ];
  }
}
