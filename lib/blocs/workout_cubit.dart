// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';

import '/models/workout.dart';
import '/states/workout_state.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit() : super(const WorkoutIntial());

  editWorkout(Workout workout, int index) {
    return emit(WorkoutEditing(workout, index, null));
  }

  editExercise(int? exIndex) {
    print('My exercise index - exIndex is $exIndex');
    return emit(
      WorkoutEditing(state.workout!, (state as WorkoutEditing).index, exIndex),
    );
  }

  goHome() => emit(const WorkoutIntial());
}
