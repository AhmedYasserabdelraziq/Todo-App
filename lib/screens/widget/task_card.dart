import 'package:flutter/material.dart';

import '../view_model/tasks_view_model.dart';

class BuildCard extends StatelessWidget {
  final TasksViewModel viewModel;
  final int index;

  const BuildCard({super.key, required this.viewModel, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(viewModel.todos[index].title.toString()),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Divider(
              height: 1,
              thickness: 2,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(viewModel.todos[index].description.toString()),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
