import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/view/tasks_screen.dart';

import '../view_model/bottom_nav_bar_view_model.dart';
import 'archived_screen.dart';
import 'done_screen.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var selected = Provider.of<BottomNavBarViewModel>(context);
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
      appBar: AppBar(
        title: Text(title[selected.currentNum].toString()),
      ),
      body: screens[selected.currentNum],
      bottomNavigationBar: Consumer<BottomNavBarViewModel>(
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
    );
  }
}
