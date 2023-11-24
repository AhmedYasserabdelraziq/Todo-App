import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/model/todo_model.dart';
import 'package:todo_app/screens/view_model/tasks_view_model.dart';
import 'package:todo_app/screens/widget/task_card.dart';
import 'package:todo_app/utils/extintions.dart';

import '../widget/bottom_sheet.dart';
import 'no_tasks_screen.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key, required this.todo});

  final void Function(TodoModel todo) todo;

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<TasksViewModel>(context);
    return viewModel.todos.isNotEmpty
        ? Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 10.0, left: 10.0, top: 70),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Wrap(
                              children: List.generate(
                                viewModel.todos.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Dismissible(
                                    onDismissed: (_) async {
                                      await viewModel
                                          .deleteData(viewModel.todos[index]);
                                      viewModel.todos.removeAt(index);
                                    },
                                    direction: DismissDirection.startToEnd,
                                    background: Stack(
                                      children: [
                                        Container(
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        const Positioned(
                                          top: 45,
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                            size: 50,
                                          ),
                                        ),
                                      ],
                                    ),
                                    key: ValueKey(viewModel.todos[index]),
                                    child: BuildCard(
                                      todos: viewModel.todos[index],
                                      viewModel: viewModel,
                                    ).onTap(() {
                                      todo(viewModel.todos[index]);
                                      if (viewModel.update) {
                                        viewModel.currentDataToUpdated(
                                            viewModel.todos[index]);
                                        buildBottomSheet(viewModel, context);
                                      } else {
                                        viewModel.currentDataToUpdated(
                                            viewModel.todos[index]);
                                        buildBottomSheet(viewModel, context);
                                        viewModel.closeUpdatedBottomSheet();
                                        print(viewModel.update);
                                      }
                                    }, borderRadius: BorderRadius.circular(15)),
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
              ),
            ],
          )
        : const NoTasksScreen();
  }
}
