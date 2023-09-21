import 'package:flutter/material.dart';
import 'package:todo_app/screens/model/todo_model.dart';
import 'package:todo_app/services/local_services.dart';

class TasksViewModel extends ChangeNotifier {
  final LocalServices localServices;

  TasksViewModel({required this.localServices});

  int currentNum = 0;

  void currentIndex(int index) {
    currentNum = index;
    notifyListeners();
  }

  void createData() async {
    await localServices.createDataBase();
  }

  void addData(TodoModel todo) async {
    await localServices.addTodo(todo);
  }

  void updateData(TodoModel todo) async {
    await localServices.updateTodo(todo);
  }

  void deleteData(TodoModel todo) async {
    await localServices.deleteTodo(todo);
  }
}
