import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/model/todo_model.dart';
import 'package:todo_app/screens/view_model/tasks_view_model.dart';
import 'package:todo_app/utils/extintions.dart';

import '../widget/bottom_sheet.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key, required this.todo});
final void Function (TodoModel todo) todo;
  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<TasksViewModel>(context, listen: true);
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
                    child: Text(viewModel.todos[index].description.toString()),
                  ),
                ),
              ],
            ),
          ).onTap(() {
            todo(viewModel.todos[index]);
            if (viewModel.update) {
            } else {
              buildBottomSheet(viewModel, context,null);
              viewModel.closeUpdatedBottomSheet();
              print(viewModel.update);
            }
          });
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: viewModel.todos.length,
      ),
    );
  }
}
