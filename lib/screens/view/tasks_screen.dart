import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/model/todo_model.dart';
import 'package:todo_app/screens/view_model/tasks_view_model.dart';
import 'package:todo_app/screens/widget/day_card.dart';
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
    var viewModel = Provider.of<TasksViewModel>(context);
    return Stack(
      children: [
        Column(
          children: [
            CustomAppbar(
              title: 'To Do List',
              hieght: 200,
              backgroundColor: AppColors.primary,
            ),
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
                          viewModel.todos.length,
                          (index) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: BuildCard(
                              viewModel: viewModel.todos[index],
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
                            }),
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
        Positioned(
          top: 180,
          child: SizedBox(
            height: 117,
            width: 500,
            child: Row(
              children: List.generate(
                5,
                (index) {
                  DateTime? dayToShow = now.add(Duration(days: index));
                  DateTime dateOnly =
                      DateTime(dayToShow.year, dayToShow.month, dayToShow.day);
                  return DayCard(
                    dayToShow: dayToShow,
                    color: AppColors.primary,
                    text: viewModel.weekDayName(dayToShow.weekday),
                  ).onTap(() {
                    viewModel.getAllData(
                      dateOnly,
                    );
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
