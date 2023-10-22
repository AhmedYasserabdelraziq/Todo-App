import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/view/no_tasks_screen.dart';
import 'package:todo_app/screens/widget/task_card.dart';

import '../view_model/tasks_view_model.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<TasksViewModel>(context);
    return viewModel.todosDone.isNotEmpty
        ? Column(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 10.0, left: 10.0, top: 70),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Wrap(
                          children: List.generate(
                            viewModel.todosDone.length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: BuildCard(
                                todos: viewModel.todosDone[index],
                                viewModel: viewModel,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        : const NoTasksScreen();
  }
}
