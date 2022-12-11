// ignore_for_file: avoid_print

import 'dart:async';
import 'package:wakelock/wakelock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/models/workout.dart';
import '../states/workout_states.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit() : super(const WorkoutIntial());

  Timer? _timer;

  editWorkout(Workout workout, int index) {
    return emit(WorkoutEditing(workout, index, null));
  }

  editExercise(int? exIndex) => emit(
        WorkoutEditing(
            state.workout!, (state as WorkoutEditing).index, exIndex),
      );

  pauseWorkout() => emit(WorkoutPaused(state.workout, state.elapsed));

  resumeWorkout() => emit(WorkoutInProgress(state.workout, state.elapsed));

  goHome() => emit(const WorkoutIntial());

  onTick(Timer timer) {
    if (state is WorkoutInProgress) {
      WorkoutInProgress wip = state as WorkoutInProgress;
      if (wip.elapsed! < wip.workout!.getTotal()) {
        emit(WorkoutInProgress(wip.workout, wip.elapsed! + 1));
        print('My elapsed time: ${wip.elapsed}');
      } else {
        _timer!.cancel();
        Wakelock.disable();
        emit(const WorkoutIntial());
      }
    }
  }

  startWorkout(Workout workout, [int? index]) {
    Wakelock.enable();
    if (index != null) {
    } else {
      emit(WorkoutInProgress(workout, 0));
    }
    _timer = Timer.periodic(const Duration(seconds: 1), onTick);
  }
}
