import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/helpers.dart';
import '/models/workout.dart';
import '/blocs/workout_cubit.dart';
import '/blocs/workouts_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Time!'),
        actions: [
          IconButton(
            icon: const Icon(Icons.event_available),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<WorkoutsCubit, List<Workout>>(
          builder: (context, workouts) => ExpansionPanelList.radio(
            children: workouts
                .map(
                  (workout) => ExpansionPanelRadio(
                    value: workout,
                    headerBuilder: (BuildContext context, bool isExpanded) =>
                        ListTile(
                      visualDensity: const VisualDensity(
                        horizontal: 0,
                        vertical: VisualDensity.maximumDensity,
                      ),
                      leading: IconButton(
                        onPressed: () {
                          BlocProvider.of<WorkoutCubit>(context)
                              .editWorkout(workout, workouts.indexOf(workout));
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      title: Text(workout.title!),
                      trailing: Text(formatTime(workout.getTotal(), true)),
                      onTap: () => !isExpanded
                          ? BlocProvider.of<WorkoutCubit>(context)
                              .startWorkout(workout)
                          : null,
                    ),
                    body: ListView.builder(
                      shrinkWrap: true,
                      itemCount: workout.exercises.length,
                      itemBuilder: (BuildContext context, int index) =>
                          ListTile(
                        onTap: () {},
                        visualDensity: const VisualDensity(
                          horizontal: 0,
                          vertical: VisualDensity.maximumDensity,
                        ),
                        leading: Text(
                          formatTime(workout.exercises[index].prelude!, true),
                        ),
                        title: Text(workout.exercises[index].title!),
                        trailing: Text(
                          formatTime(workout.exercises[index].duration!, true),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
