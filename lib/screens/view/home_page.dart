import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/view/tasks_screen.dart';
import 'package:todo_app/screens/view_model/tasks_view_model.dart';
import 'package:todo_app/screens/widget/bottom_sheet.dart';

import 'archived_screen.dart';
import 'done_screen.dart';

var key = GlobalKey<ScaffoldState>();

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    final viewModel = Provider.of<TasksViewModel>(context);
    viewModel.createData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List screens = [
      const TasksScreen(),
      const DoneScreen(),
      const ArchivedScreen(),
    ];
    List title = [
      'Tasks',
      'Done Tasks',
      'Archived Tasks',
    ];
    return Consumer<TasksViewModel>(
      builder: (ct, viewModel, _) {
        return Scaffold(
          key: key,
          appBar: AppBar(
            title: Text(title[viewModel.currentNum].toString()),
          ),
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
          floatingActionButton: FloatingActionButton(
            child: viewModel.opened
                ? const Icon(Icons.add)
                : const Icon(Icons.edit),
            onPressed: () {
              if (viewModel.opened == true) {
                viewModel.addData();
                Navigator.of(context).pop();
                viewModel.closeBottomSheet();
              } else {
                key.currentState!.showBottomSheet(
                    elevation: 30,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    (context) => buildBottomSheet(viewModel),
                    backgroundColor: Colors.grey[200]);
                viewModel.closeBottomSheet();
              }
            },
          ),
        );
      },
    );
  }
}
