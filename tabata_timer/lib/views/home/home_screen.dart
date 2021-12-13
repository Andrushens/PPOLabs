import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabata_timer/entities/workout.dart';
import 'package:tabata_timer/services/background_timer/background_timer.dart';
import 'package:tabata_timer/services/locale/locale_cubit.dart';
import 'package:tabata_timer/views/home/home_cubit.dart';
import 'package:tabata_timer/views/widgets/drawer.dart';
import 'package:tabata_timer/views/widgets/workout_container.dart';
import 'package:tabata_timer/views/workout/workout_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<HomeCubit>().init(),
      builder: (context, snapshot) {
        return BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, _) {
            return BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                var workouts = state.workouts;
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    title: Center(
                      child: Text(
                        '${context.read<LocaleCubit>().state.consts['workouts']}: ${workouts.length}',
                      ),
                    ),
                  ),
                  drawer: const CustomDrawer(),
                  floatingActionButton: FloatingActionButton(
                    onPressed: state.selectedWorkouts.isEmpty
                        ? () async {
                            var workout = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return const WorkoutScreen();
                                },
                              ),
                            ) as Workout?;
                            context.read<HomeCubit>().addWorkout(workout);
                          }
                        : context.read<HomeCubit>().deleteWorkouts,
                    child: Icon(
                      state.selectedWorkouts.isEmpty
                          ? Icons.add
                          : Icons.delete_outline_rounded,
                      size: 32,
                    ),
                  ),
                  body: ListView.builder(
                    itemCount: workouts.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: WorkoutContainer(
                          workout: workouts[index],
                          isSelected: state.selectedWorkouts.contains(
                            workouts[index].id,
                          ),
                          onTap: context.read<HomeCubit>().onWorkoutTap,
                          onLongPress:
                              context.read<HomeCubit>().onWorkoutLongPress,
                          onButtonPressed: () async {
                            var workout = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return WorkoutScreen(
                                    workout: workouts[index],
                                  );
                                },
                              ),
                            ) as Workout;
                            context.read<HomeCubit>().updateWorkout(workout);
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
