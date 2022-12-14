// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'blocs/workout_cubit.dart';
import 'screens/home_screen.dart';
import 'blocs/workouts_cubit.dart';
import 'states/workout_states.dart';
import 'screens/workout_progress.dart';
import 'screens/edit_workout_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  runApp(const WorkoutTime());
}

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
      home: MultiBlocProvider(
        providers: [
          BlocProvider<WorkoutsCubit>(
            create: (BuildContext context) {
              WorkoutsCubit workoutsCubit = WorkoutsCubit();
              if (workoutsCubit.state.isEmpty) {
                workoutsCubit.getWorkouts();
                print('Load json file successfully');
              } else {
                workoutsCubit.getWorkouts();
                print('Error load json file, return workoutsCubit');
              }
              return workoutsCubit;
            },
          ),
          BlocProvider<WorkoutCubit>(
            create: (BuildContext context) {
              return WorkoutCubit();
            },
          ),
        ],
        child: BlocBuilder<WorkoutCubit, WorkoutState>(
          builder: (context, state) {
            if (state is WorkoutIntial) {
              return const HomeScreen();
            } else if (state is WorkoutEditing) {
              return const EditWorkoutScreen();
            }
            return const WorkoutProgress();
          },
        ),
      ),
    );
  }
}
