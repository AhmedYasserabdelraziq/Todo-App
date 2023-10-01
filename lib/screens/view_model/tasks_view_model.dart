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
  TimeOfDay? dateOfTask;

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
    if (title.isNotEmpty && description.isNotEmpty && dateOfTask != null) {
      var addModel = TodoModel(
          title: title,
          description: description,
          dateTime: formatTimeOfDay(dateOfTask!));
      await localServices.insertTodo(addModel);

      getAllData();
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
          dateTime: formatTimeOfDay(dateOfTask!),
        ),
      );
    }
    getAllData();
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
    dateOfTask = stringToTimeOfDay(todo.dateTime.toString());
    notifyListeners();
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

  void selectDate(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      dateOfTask = pickedTime;
      print(dateOfTask);
    }
    notifyListeners();
  }

  String formatTimeOfDay(TimeOfDay date) {
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

  TimeOfDay stringToTimeOfDay(String timeString) {
    final format =
        RegExp(r'(?<hour>\d{1,2}):(?<minute>\d{2})\s?(?<period>AM|PM)?');

    final match = format.firstMatch(timeString);

    if (match != null) {
      int hour = int.parse(match.namedGroup('hour')!);
      final minute = int.parse(match.namedGroup('minute')!);
      final period = match.namedGroup('period');

      if (period != null) {
        if (hour == 12 && period == 'AM') {
          hour = 0;
        } else if (hour < 12 && period == 'PM') {
          hour += 12;
        }
      }

      return TimeOfDay(hour: hour, minute: minute);
    }

    throw const FormatException('Invalid time format');
  }
}
