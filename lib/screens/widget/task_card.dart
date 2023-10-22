import 'package:flutter/material.dart';
import 'package:todo_app/screens/model/todo_model.dart';
import 'package:todo_app/screens/view_model/tasks_view_model.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/extintions.dart';

class BuildCard extends StatelessWidget {
  final TodoModel todos;
  final TasksViewModel viewModel;

  const BuildCard({super.key, required this.todos, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: SizedBox(
          height: 120,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: VerticalDivider(
                  color: todos.tasksDone == 'done'
                      ? AppColors.taskDoneColor
                      : AppColors.primary,
                  thickness: 3, // defines the width of the line
                  width: 20, // total width of divider, including empty space
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todos.title!,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: todos.tasksDone == 'done'
                              ? AppColors.taskDoneColor
                              : AppColors.primary),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      todos.description!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.access_time_rounded),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          todos.dateTime.toString(),
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: todos.tasksDone == 'done'
                    ? Text(
                        'Done!',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: AppColors.taskDoneColor),
                      ).onTap(() {
                        viewModel.removeTasksDone('notDone');
                        viewModel.updateData(
                          TodoModel(
                            id: todos.id,
                            title: todos.title,
                            description: todos.description,
                            dateTime: todos.dateTime,
                            dayTime: todos.dayTime,
                            tasksDone: viewModel.tasksState,
                          ),
                        );
                        viewModel.donePage
                            ? viewModel.getAllDoneData(viewModel.daytime)
                            : null;
                      })
                    : ElevatedButton(
                        onPressed: () {
                          viewModel.taskDone('done');
                          viewModel.updateData(
                            TodoModel(
                              id: todos.id,
                              title: todos.title,
                              description: todos.description,
                              dateTime: todos.dateTime,
                              dayTime: todos.dayTime,
                              tasksDone: viewModel.tasksState,
                            ),
                          );
                        },
                        child: const Icon(Icons.check),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
