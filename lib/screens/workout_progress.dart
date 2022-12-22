import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter_bloc_workout_time_app/helpers.dart';
import 'package:flutter_bloc_workout_time_app/models/exercise.dart';

import '/models/workout.dart';
import '/blocs/workout_cubit.dart';
import '../states/workout_states.dart';

class WorkoutProgress extends StatelessWidget {
  const WorkoutProgress({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> getStats(Workout workout, int workoutElapsed) {
      int workoutTotal = workout.getTotal();
      Exercise exercise = workout.getCurrentExercise(workoutElapsed);
      int exerciseElapsed = workoutElapsed = exercise.startTime!;
      int exerciseRemaining = exercise.prelude! - exerciseElapsed;
      bool isPrelude = exerciseElapsed < exercise.prelude!;
      int exerciseTotal = isPrelude ? exercise.prelude! : exercise.duration!;

      if (!isPrelude) {
        exerciseElapsed -= exercise.prelude!;
        exerciseElapsed += exercise.duration!;
      }

      return {
        'isPrelude': isPrelude,
        'workoutTitle': workout.title,
        'totalExercise': workout.exercises.length,
        'workoutElapsed': workoutElapsed,
        'workoutProgress': workoutElapsed / workoutTotal,
        'exerciseProgress': exerciseElapsed / exerciseTotal,
        'workoutRemaining': workoutTotal - workoutElapsed,
        'exerciseRemaining': exerciseRemaining,
        'currentExerciseIndex': exercise.index!.toDouble(),
      };
    }

    return BlocConsumer<WorkoutCubit, WorkoutState>(
      builder: (context, state) {
        final stats = getStats(state.workout!, state.elapsed!);
        return Scaffold(
          appBar: AppBar(
            title: Text(state.workout!.title.toString()),
            leading: BackButton(
              onPressed: () => BlocProvider.of<WorkoutCubit>(context).goHome(),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: stats['workoutProgress'],
                  minHeight: 10,
                  backgroundColor: Colors.blue[100],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(formatTime(stats['workoutElapsed'], true)),
                      DotsIndicator(
                        dotsCount: stats['totalExercise'],
                        position: stats['currentExerciseIndex'],
                      ),
                      Text(
                        ' - ${formatTime(stats['workoutRemaining'], true)}',
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  child: Stack(
                    alignment: const Alignment(0, 0),
                    children: [
                      Center(
                        child: SizedBox(
                          width: 220,
                          height: 220,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              stats['isPrelude'] ? Colors.red : Colors.blue,
                            ),
                            strokeWidth: 25,
                            value: stats['exerciseProgress'],
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: 300,
                          height: 300,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Image.asset('stopwatch.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    if (state is WorkoutProgress) {
                      BlocProvider.of<WorkoutCubit>(context).pauseWorkout();
                    } else if (state is WorkoutPaused) {
                      BlocProvider.of<WorkoutCubit>(context).resumeWorkout();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
