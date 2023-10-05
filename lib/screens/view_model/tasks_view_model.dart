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
  String? dateOfTask;
  DateTime? daytime;
  var opened = false;
  var update = false;
  var taskDone = false;
  int? selectedCardDay = DateTime.now().day;

  void currentIndex(int index) {
    currentNum = index;
    notifyListeners();
  }

  Future? selectedDay(int? index) {
    selectedCardDay = index;
    print(selectedCardDay);
    notifyListeners();
    return null;
  }

  closeAddedBottomSheet() {
    opened = !opened;
    notifyListeners();
  }

  closeUpdatedBottomSheet() {
    update = !update;
    notifyListeners();
  }

  void tasksDone() {
    taskDone = !taskDone;
    notifyListeners();
  }

  void createData() async {
    DateTime now = DateTime.now();
    DateTime dateOnly = DateTime(now.year, now.month, now.day);
    await localServices.database;
    getAllData(dateOnly);
    notifyListeners();
    print('createdDatabase');
  }

  void addData() async {
    var title = titleTaskController.value.text;
    var description = descriptionTaskController.value.text;
    if (title.isNotEmpty && description.isNotEmpty && dateOfTask != null) {
      var addModel = TodoModel(
        title: title,
        description: description,
        dateTime: dateOfTask!,
        dayTime: daytime.toString(),
      );
      await localServices.insertTodo(addModel);

      getAllData(daytime);
      notifyListeners();
      print('refreshed');
    }
    reset();
  }

  updateData(TodoModel todo) async {
    var title = titleTaskController.value.text;
    var description = descriptionTaskController.value.text;
    if (title.isNotEmpty && description.isNotEmpty) {
      await localServices.updateTodo(
        TodoModel(
            id: todo.id,
            title: titleTaskController.text,
            description: descriptionTaskController.text,
            dateTime: dateOfTask!,
            dayTime: daytime.toString()),
      );
    }
    print(daytime);
    getAllData(daytime);
    notifyListeners();
    print('updated');
  }

  void deleteData(TodoModel todo) async {
    await localServices.deleteTodo(todo);
    notifyListeners();
    print('deleted');
  }

  void getAllData(DateTime? dateTime) async {
    final data = await localServices.getAllTodos(dateTime.toString());
    todos = data;
    notifyListeners();
    print('getAll');
  }

  void reset() {
    titleTaskController.clear();
    descriptionTaskController.clear();
    dateOfTask = null;
  }

  void currentDataToUpdated(TodoModel todo) {
    titleTaskController.text = todo.title;
    descriptionTaskController.text = todo.description;
    dateOfTask = todo.dateTime;
    daytime = DateTime.parse(todo.dayTime!);
    notifyListeners();
  }

  String weekDayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tues';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  String timeOfDayToString(TimeOfDay date) {
    int hour = date.hour;
    int minute = date.minute;
    String period = "AM";

    if (hour == 0) {
      hour = 12; // midnight is shown as 12 AM
    } else if (hour == 12) {
      period = "PM"; // noon is shown as 12 PM
    } else if (hour > 12) {
      hour -= 12; // subtract 12 for PM times
      period = "PM";
    }

    String minuteStr = minute < 10
        ? '0$minute'
        : '$minute'; // format minutes to have two digits
    return '$hour:$minuteStr $period';
  }

  currentDateToSelect(TimeOfDay timeOfDay) {
    dateOfTask = timeOfDayToString(timeOfDay);
    notifyListeners();
  }

  void setCompleteDate(DateTime date) {
    daytime = date;
    setState();
  }
}
