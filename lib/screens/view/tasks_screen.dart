import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/model/todo_model.dart';
import 'package:todo_app/screens/view_model/tasks_view_model.dart';
import 'package:todo_app/screens/widget/task_card.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/extintions.dart';
import 'package:todo_app/widget/custom_appbar.dart';

import '../widget/bottom_sheet.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key, required this.todo});

  final void Function(TodoModel todo) todo;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now().subtract(const Duration(days: 2));
    List title = [
      'Tasks',
      'Done Tasks',
      'Archived Tasks',
    ];
    var viewModel = Provider.of<TasksViewModel>(context, listen: true);
    return Column(
      children: [
        CustomAppbar(
          title: 'To Do List',
          hieght: 200,
          backgroundColor: AppColors.primary,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Wrap(
                    children: List.generate(
                      viewModel.todos.length,
                      (index) => BuildCard(
                        index: index,
                        viewModel: viewModel,
                      ).onTap(() {
                        todo(viewModel.todos[index]);
                        if (viewModel.update) {
                        } else {
                          buildBottomSheet(viewModel, context);
                          viewModel.closeUpdatedBottomSheet();
                          print(viewModel.update);
                        }
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
// Stack
// (
// children: [
// Column(
// children: [

// ],
// ),
// Positioned(
// top: 180,
// child: SizedBox(
// height: 117,
// width: 500,
// child: ListView.builder(
// itemCount: 5,
// itemBuilder: (context, index) {
// DateTime? dayToShow = now.add(Duration(days: index));
// return DayCard(dayToShow: dayToShow);
// },
// scrollDirection: Axis.horizontal,
// ),
// ),
// )
// ,
// ]
// ,
// )
// ,
