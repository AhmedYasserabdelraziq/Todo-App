import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/view/tasks_screen.dart';
import 'package:todo_app/screens/widget/bottom_sheet.dart';

import '../view_model/tasks_view_model.dart';
import 'archived_screen.dart';
import 'done_screen.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<ScaffoldState>();

    var selected = Provider.of<TasksViewModel>(context);
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
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text(title[selected.currentNum].toString()),
      ),
      body: screens[selected.currentNum],
      bottomNavigationBar: Consumer<TasksViewModel>(
        builder: (ctx, viewModel, _) {
          return BottomNavigationBar(
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
              ]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () {
          key.currentState!.showBottomSheet(
            elevation: 30,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            (context) => buildBottomSheet(),
            backgroundColor: Colors.grey[200]
          );
        },
      ),
    );
  }
}
