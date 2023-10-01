import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/view/tasks_screen.dart';
import 'package:todo_app/screens/view_model/tasks_view_model.dart';
import 'package:todo_app/screens/widget/bottom_sheet.dart';
import 'package:todo_app/utils/colors.dart';

import '../base_view.dart';
import '../model/todo_model.dart';
import 'archived_screen.dart';
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
    List screens = [
      TasksScreen(
        todo: (todo) {
          print('this todoID${todo.id}');
          todoModel = todo;
        },
      ),
      const DoneScreen(),
      const ArchivedScreen(),
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
          body: screens[viewModel.currentNum],
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
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive),
                  label: ('Tasks'),
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
                    viewModel.updateData(todoModel!);
                    Navigator.of(context).pop();
                  } else {
                    if (viewModel.opened == true) {
                      viewModel.addData();
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
                            backgroundColor: Colors.grey[200],
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
