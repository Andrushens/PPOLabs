import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabata_timer/entities/workout.dart';
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
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimerCubit(widget.workout),
      child: BlocBuilder<TimerCubit, TimerState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: Navigator.of(context).pop,
                icon: const Icon(
                  Icons.arrow_back,
                  size: 40,
                ),
              ),
              centerTitle: true,
              title: Text(
                state.currentPhase,
                style: const TextStyle(fontSize: 34),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    onPressed: state.isActive
                        ? context.read<TimerCubit>().stopTimer
                        : context.read<TimerCubit>().startTimer,
                    icon: Icon(
                      state.isActive
                          ? Icons.stop_rounded
                          : Icons.play_arrow_rounded,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      CircleAvatar(
                        radius: 156,
                        backgroundColor: Theme.of(context)
                            .buttonTheme
                            .colorScheme!
                            .background,
                        child: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          radius: 150,
                          child: Text(
                            state.currentDuration.toString(),
                            style: const TextStyle(fontSize: 100),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: List.generate(
                          state.totalCycles,
                          (index) {
                            var id = index % 2;
                            var phase = index == 0
                                ? 'Prepare'
                                : index == state.totalCycles - 1
                                    ? 'Finish'
                                    : id % 2 == 1
                                        ? 'Work'
                                        : 'Rest';
                            var duration = index == 0
                                ? state.workout.prepareTime
                                : id % 2 == 1
                                    ? state.workout.workTime
                                    : state.workout.restTime;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: TimerPhaseContainer(
                                index: index + 1,
                                phase: phase,
                                duration: duration,
                                onTap: () {},
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
          );
        },
      ),
    );
  }
}
