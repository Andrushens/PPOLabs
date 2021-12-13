import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabata_timer/entities/workout.dart';
import 'package:tabata_timer/services/background_timer/background_timer.dart';
import 'package:tabata_timer/views/timer/timer_cubit.dart';
import 'package:tabata_timer/views/widgets/timer_phase_container.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({
    required this.workout,
    Key? key,
  }) : super(key: key);

  final Workout workout;

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  @override
  void dispose() {
    stopTimerService();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimerCubit(widget.workout, context),
      child: BlocBuilder<TimerCubit, TimerState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              centerTitle: true,
              leading: BackButton(
                onPressed: () {
                  stopTimerService();
                  Navigator.of(context).pop();
                },
              ),
              title: Text(
                state.currentPhaseString,
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          state.isActive
                              ? context.read<TimerCubit>().stopTimer()
                              : context.read<TimerCubit>().startTimer(context);
                        },
                        child: CircleAvatar(
                          radius: 156,
                          backgroundColor: state.isActive
                              ? Theme.of(context).colorScheme.primary
                              : Colors.red.withOpacity(0.3),
                          child: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            radius: 150,
                            child: Text(
                              state.currentDuration.toString(),
                              style: TextStyle(
                                fontSize: 100,
                                color: state.isActive
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.red.withOpacity(0.7),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: List.generate(
                          state.totalCycles,
                          (index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: TimerPhaseContainer(
                                index: index,
                                isActive: index == state.currentPhaseIndex,
                                phase: context
                                    .read<TimerCubit>()
                                    .getPhaseByIndex(index, context),
                                duration: context
                                    .read<TimerCubit>()
                                    .getDurationByIndex(index),
                                onTap: () {
                                  context
                                      .read<TimerCubit>()
                                      .changePhase(index, context);
                                },
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              color: Theme.of(context).colorScheme.primary,
              child: SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () =>
                          context.read<TimerCubit>().skipPreviousPhase(context),
                      icon: const Icon(Icons.skip_previous_rounded),
                      color: Theme.of(context).colorScheme.onPrimary,
                      iconSize: 60,
                    ),
                    IconButton(
                      onPressed: () {
                        state.isActive
                            ? context.read<TimerCubit>().stopTimer()
                            : context.read<TimerCubit>().startTimer(context);
                      },
                      icon: Icon(
                        state.currentPhaseIndex == state.totalCycles - 1
                            ? Icons.replay
                            : state.isActive
                                ? Icons.stop_rounded
                                : Icons.play_arrow_rounded,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      iconSize: 60,
                    ),
                    IconButton(
                      onPressed: () =>
                          context.read<TimerCubit>().skipNextPhase(context),
                      icon: const Icon(Icons.skip_next_rounded),
                      iconSize: 60,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
