import 'package:flutter/material.dart';
import 'package:todo_app/screens/base_view.dart';
import 'package:todo_app/screens/view_model/tasks_view_model.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<TasksViewModel>(
      onModelReady: (viewModel) {
        viewModel.createData();
      },
      builder: (ctx, viewModel, _) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
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
                        child:
                            Text(viewModel.todos[index].description.toString()),
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount: viewModel.todos.length,
          ),
        );
      },
    );
  }
}
