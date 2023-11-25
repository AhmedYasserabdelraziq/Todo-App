import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/view/tasks_screen.dart';
import 'package:todo_app/screens/view_model/tasks_view_model.dart';
import 'package:todo_app/screens/widget/bottom_sheet.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/extintions.dart';

import '../../widget/custom_appbar.dart';
import '../base_view.dart';
import '../model/todo_model.dart';
import '../widget/addin_new_day.dart';
import '../widget/day_card.dart';
import 'done_screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var key = GlobalKey<ScaffoldState>();
  TodoModel? todoModel;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now().subtract(const Duration(days: 2));
    Size size = MediaQuery.of(context).size;
    List screens = [
      TasksScreen(
        todo: (todo) {
          print('this todoID${todo.id}');
          todoModel = todo;
        },
      ),
      const DoneScreen(),
    ];

    return BaseView<TasksViewModel>(
      onModelReady: (viewModel) {
        viewModel.createData();
      },
      builder: (ct, viewModel, _) {
        return Scaffold(
          backgroundColor: AppColors.background,
          extendBodyBehindAppBar: true,
          key: key,
          body: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomAppbar(
                    title: 'To Do List',
                    hieght: 200,
                    backgroundColor: AppColors.primary,
                  ),
                  Expanded(
                    child: viewModel.loading
                        ? const Center(child: CircularProgressIndicator())
                        : screens[viewModel.currentNum],
                  )
                ],
              ),
              Positioned(
                top: 180,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    const EditingDay(true).onTap(() {
                      now = now.add(const Duration(days: -1));
                      viewModel.refresh();
                    }),
                    Wrap(
                      children: List.generate(
                        5,
                        (index) {
                          DateTime? dayToShow =
                              now.add(Duration(days: index));
                          DateTime dateSelected = DateTime(
                              dayToShow.year, dayToShow.month, dayToShow.day);
                          return InkWell(
                            onTap: () {
                              viewModel.selectedDay(dayToShow.day);
                              viewModel.donePage
                                  ? viewModel.getAllDoneData(
                                      dateSelected,
                                    )
                                  : viewModel.getAllData(
                                      dateSelected,
                                    );
                              viewModel.currentDate(dateSelected);
                            },
                            child: DayCard(
                              dayToShow: dayToShow,
                              color: AppColors.primary,
                              text: viewModel.weekDayName(dayToShow.weekday),
                              selectDay: viewModel.selectedCardDay,
                            ),
                          );
                        },
                      ),
                    ),
                    const EditingDay(false).onTap(() {
                      now = now.add(const Duration(days: 1));
                      viewModel.refresh();
                    }),
                  ]),
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: viewModel.currentNum,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                viewModel.currentIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: ('Tasks'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline),
                  label: ('Done'),
                ),
              ]),
          floatingActionButton: Consumer<TasksViewModel>(
            builder: (ctx, viewModel, _) {
              return FloatingActionButton(
                child: !viewModel.update
                    ? viewModel.opened
                        ? const Icon(Icons.add)
                        : const Icon(Icons.arrow_drop_up)
                    : const Icon(Icons.edit),
                onPressed: () {
                  if (viewModel.update) {
                    print('this todoID2${todoModel!.id}');
                    viewModel.updateData(
                      TodoModel(
                        id: todoModel!.id,
                        title: viewModel.titleTaskController.text,
                        description: viewModel.descriptionTaskController.text,
                        dateTime: viewModel.dateOfTask!,
                        dayTime: viewModel.daytime.toString(),
                        tasksDone: todoModel!.tasksDone,
                      ),
                    );
                    viewModel.reset();
                    Navigator.of(context).pop();
                  } else {
                    if (viewModel.opened == true) {
                      viewModel.addData();
                      print(viewModel.daytime);
                      Navigator.of(context).pop();
                    } else {
                      viewModel.closeAddedBottomSheet();
                      key.currentState!
                          .showBottomSheet(
                            elevation: 30,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                            ),
                            (context) => bottomSheetContent(viewModel, context),
                            backgroundColor: AppColors.bottomSheetColor,
                          )
                          .closed
                          .then((value) {
                        viewModel.closeAddedBottomSheet();
                      });
                    }
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}
