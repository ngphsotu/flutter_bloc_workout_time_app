import 'package:flutter_bloc/flutter_bloc.dart';

import '/models/workout.dart';
import '/states/workout_state.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit() : super(const WorkoutIntial());

  editWorkout(Workout workout, int index) {
    return emit(WorkoutEditing(workout, index));
  }

  goHome() {
    emit(const WorkoutIntial());
  }
}
