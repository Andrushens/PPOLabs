import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabata_timer/entities/workout.dart';
import 'package:tabata_timer/views/widgets/phase_container.dart';
import 'package:tabata_timer/views/workout/workout_cubit.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({
    this.workout,
    Key? key,
  }) : super(key: key);

  final Workout? workout;

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WorkoutCubit(widget.workout),
      child: BlocBuilder<WorkoutCubit, WorkoutState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () async {
                  Navigator.of(context).pop(state.workout);
                },
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.workout!.name),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.settings),
                ),
              ],
            ),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.all(8),
                        ),
                      ),
                      onPressed: () {},
                      child: const Expanded(
                        child: Text(
                          'START',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  PhaseContainer(
                    title: state.workout!.name,
                    icon: Icons.text_fields,
                    onTextChanged: context.read<WorkoutCubit>().updateTitle,
                  ),
                  PhaseContainer(
                    title: 'Prepare',
                    icon: Icons.accessible,
                    amount: state.workout!.prepareTime,
                    onAddPressed:
                        context.read<WorkoutCubit>().increasePrepareTime,
                    onSubPressed:
                        context.read<WorkoutCubit>().decreasePrepareTime,
                  ),
                  PhaseContainer(
                    title: 'Work',
                    icon: Icons.accessible_forward_outlined,
                    amount: state.workout!.workTime,
                    onAddPressed: context.read<WorkoutCubit>().increaseWorkTime,
                    onSubPressed: context.read<WorkoutCubit>().decreaseWorkTime,
                  ),
                  PhaseContainer(
                    title: 'Rest',
                    icon: Icons.accessibility_new_outlined,
                    amount: state.workout!.restTime,
                    onAddPressed: context.read<WorkoutCubit>().increaseRestTime,
                    onSubPressed: context.read<WorkoutCubit>().decreaseRestTime,
                  ),
                  PhaseContainer(
                    title: 'Cycles',
                    icon: Icons.replay,
                    amount: state.workout!.cycles,
                    onAddPressed: context.read<WorkoutCubit>().increaseCycles,
                    onSubPressed: context.read<WorkoutCubit>().decreaseCycles,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
