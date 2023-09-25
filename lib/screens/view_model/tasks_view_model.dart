import 'package:flutter/material.dart';
import 'package:todo_app/screens/base_view_model.dart';
import 'package:todo_app/screens/model/todo_model.dart';
import 'package:todo_app/services/local_services.dart';

class TasksViewModel extends BaseViewModel {
  final LocalServices localServices;

  TasksViewModel({required this.localServices});

  int currentNum = 0;
  var titleTaskController = TextEditingController();
  var descriptionTaskController = TextEditingController();
  TodoModel? note;
  List<TodoModel> todos = [];
  var opened = false;

  void currentIndex(int index) {
    currentNum = index;
    notifyListeners();
  }

  closeBottomSheet() {
    opened = !opened;
    notifyListeners();
  }

  void createData() async {
    await localServices.database;
    getAllData();
    notifyListeners();
    print('createdDatabase');
  }

  void addData() async {
    var title = titleTaskController.value.text;
    var description = descriptionTaskController.value.text;
    if (title.isNotEmpty && description.isNotEmpty) {
      var model = TodoModel(title: title, description: description);
      await localServices.insertTodo(model);
    }
    getAllData();
    notifyListeners();
    print('refreshed');
  }

  void updateData(TodoModel todo) async {
    await localServices.updateTodo(todo);
    notifyListeners();
    print('updated');
  }

  void deleteData(TodoModel todo) async {
    await localServices.deleteTodo(todo);
    notifyListeners();
    print('deleted');
  }

  void getAllData() async {
    final data = await localServices.getAllTodos();
    todos = data;
    print('getAll');
  }
}
