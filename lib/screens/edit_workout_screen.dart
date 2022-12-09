import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/helpers.dart';
import '/models/exercise.dart';
import '/blocs/workout_cubit.dart';
import '/states/workout_state.dart';

class EditWorkoutScreen extends StatelessWidget {
  const EditWorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: BlocBuilder<WorkoutCubit, WorkoutState>(
        builder: (context, state) {
          WorkoutEditing we = state as WorkoutEditing;
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () =>
                    BlocProvider.of<WorkoutCubit>(context).goHome(),
              ),
              title: const Text('Workout Time!'),
            ),
            body: ListView.builder(
              itemCount: we.workout!.exercises.length,
              itemBuilder: ((context, index) {
                Exercise exercise = we.workout!.exercises[index];
                return ListTile(
                  leading: Text(formatTime(exercise.prelude!, true)),
                  title: Text(exercise.title!),
                  trailing: Text(formatTime(exercise.duration!, true)),
                );
              }),
            ),
          );
        },
      ),
      onWillPop: () => BlocProvider.of<WorkoutCubit>(context).goHome(),
    );
  }
}
