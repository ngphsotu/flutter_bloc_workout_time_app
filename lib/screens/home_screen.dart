import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/models/workout.dart';
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
            onPressed: () {},
            icon: const Icon(Icons.event_available),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<WorkoutsCubit, List<Workout>>(
          builder: (context, workouts) => ExpansionPanelList.radio(
            children: workouts
                .map(
                  (e) => ExpansionPanelRadio(
                    value: e,
                    headerBuilder: (BuildContext context, bool isExpanded) =>
                        ListTile(
                      visualDensity: const VisualDensity(
                        horizontal: 0,
                        vertical: VisualDensity.maximumDensity,
                      ),
                      leading: const IconButton(
                        onPressed: null,
                        icon: Icon(Icons.edit),
                      ),
                      title: Text(e.title!),
                    ),
                    body: Container(),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
