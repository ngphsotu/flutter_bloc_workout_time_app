// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'models/workout.dart';
import 'screens/home_screen.dart';
import 'blocs/workouts_cubit.dart';

void main() => runApp(const WorkoutTime());

class WorkoutTime extends StatelessWidget {
  const WorkoutTime({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter bloc workout time app',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: Color.fromARGB(255, 66, 74, 96)),
        ),
      ),
      home: BlocProvider<WorkoutsCubit>(
        create: (BuildContext context) {
          WorkoutsCubit workoutsCubit = WorkoutsCubit();
          if (workoutsCubit.state.isEmpty) {
            workoutsCubit.getWorkouts();
            print('Loading json since the state is empty');
          } else {
            print('The state is not empty');
          }
          return workoutsCubit;
        },
        child: BlocBuilder<WorkoutsCubit, List<Workout>>(
          builder: (context, state) {
            return const HomeScreen();
          },
        ),
      ),
    );
  }
}
