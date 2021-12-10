part of 'timer_cubit.dart';

class TimerState extends Equatable {
  final Workout workout;
  final bool isActive;
  final String currentPhase;
  final int currentDuration;
  final int totalCycles;

  const TimerState({
    required this.workout,
    this.isActive = false,
    this.currentPhase = '',
    this.currentDuration = 0,
    this.totalCycles = 0,
  });

  TimerState copyWith({
    bool? isActive,
    String? currentPhase,
    int? currentDuration,
    String? currentTotalDuration,
    int? totalCycles,
  }) {
    return TimerState(
      workout: workout,
      isActive: isActive ?? this.isActive,
      currentPhase: currentPhase ?? this.currentPhase,
      currentDuration: currentDuration ?? this.currentDuration,
      totalCycles: totalCycles ?? this.totalCycles,
    );
  }

  @override
  List<Object> get props {
    return [
      workout,
      isActive,
      currentPhase,
      currentDuration,
      totalCycles,
    ];
  }
}
