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
  var update = false;

  void currentIndex(int index) {
    currentNum = index;
    notifyListeners();
  }

  closeAddedBottomSheet() {
    opened = !opened;
    notifyListeners();
  }

  closeUpdatedBottomSheet() {
    update = !update;
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

      getAllData();
      notifyListeners();
      print('refreshed');
    }
  }

  updateData(TodoModel todo) async {
    titleTaskController.text = todo.title;
    descriptionTaskController.text = todo.description;
    var title = titleTaskController.value.text;
    var description = descriptionTaskController.value.text;
    if (title.isNotEmpty && description.isNotEmpty) {
      await localServices.updateTodo(todo);
      notifyListeners();
      print('updated');
    }
  }

  void deleteData(TodoModel todo) async {
    await localServices.deleteTodo(todo);
    notifyListeners();
    print('deleted');
  }

  void getAllData() async {
    final data = await localServices.getAllTodos();
    todos = data;
    notifyListeners();
    print('getAll');
  }


  String weekDayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }

}
