import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  List<TodoModel> todosDone = [];
  String? dateOfTask;
  DateTime? daytime;
  var opened = false;
  var update = false;
  var loading = false;
  var donePage = false;
  String? tasksState;

  int? selectedCardDay = DateTime.now().day;
  DateTime now = DateTime.now();

  void currentIndex(int index) {
    print('this is dayTime $daytime');
    currentNum = index;
    if (currentNum == 1) {
      donePage = true;
      Future.delayed(const Duration(milliseconds: 200), () {
        loadingData();
      });
      getAllDoneData(daytime);
      loadingData();
      print(donePage);
      print(currentNum);
    } else {
      donePage = false;
      Future.delayed(const Duration(milliseconds: 200), () {
        loadingData();
      });
      getAllData(daytime);
      loadingData();
    }
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

  loadingData() {
    loading = !loading;
    notifyListeners();
  }

  void taskDone(String tasDon) {
    tasksState = tasDon;
    notifyListeners();
  }

  void removeTasksDone(String removeTask) {
    tasksState = removeTask;
    notifyListeners();
  }

  void createData() async {
    daytime = DateTime(now.year, now.month, now.day);
    Future.delayed(const Duration(seconds: 2), () {
      loadingData();
    });
    await localServices.database;
    getAllData(daytime);
    loadingData();
    notifyListeners();
    print('createdDatabase');
  }

  Future addData() async {
    var title = titleTaskController.value.text;
    var description = descriptionTaskController.value.text;
    if (title.isNotEmpty && description.isNotEmpty && dateOfTask != null) {
      var addModel = TodoModel(
        title: title,
        description: description,
        dateTime: dateOfTask!,
        dayTime: daytime.toString(),
        tasksDone: 'notDone',
      );
      await localServices.insertTodo(addModel);
      getAllData(daytime);
      notifyListeners();
      print('refreshed');
      reset();
      print('reset');
    }
  }

  updateData(TodoModel todo) async {
    var title = todo.title;
    var description = todo.description;
    if (title!.isNotEmpty && description!.isNotEmpty) {
      await localServices.updateTodo(todo);
    }
    print(daytime);
    getAllData(DateTime.parse(todo.dayTime!));
    notifyListeners();
    print('updated');
  }

  void deleteData(TodoModel todo) async {
    await localServices.deleteTodo(todo);
    getAllData(daytime);
    notifyListeners();
    print('deleted');
  }

  void getAllData(DateTime? dateTime) async {
    final data = await localServices.getAllTodos(dateTime.toString());
    todos = data;
    notifyListeners();
    print('getAll');
  }

  void getAllDoneData(DateTime? dateTime) async {
    final data = await localServices.getAllDoneTodos(dateTime.toString());
    todosDone = data;
    notifyListeners();
    print('getAllDone');
  }

  void reset() {
    titleTaskController.clear();
    descriptionTaskController.clear();
    dateOfTask = null;
  }

  void currentDataToUpdated(TodoModel todo) {
    titleTaskController.text = todo.title!;
    descriptionTaskController.text = todo.description!;
    dateOfTask = todo.dateTime;
    daytime = DateTime.parse(todo.dayTime!);
    notifyListeners();
  }

  void currentDate(DateTime dateTime) {
    daytime = dateTime;
    print(daytime);
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

  String formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  currentDateToSelect(TimeOfDay timeOfDay) {
    dateOfTask = timeOfDayToString(timeOfDay);
    notifyListeners();
  }

  void setCompleteDate(DateTime date) {
    daytime = date;
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }
}
