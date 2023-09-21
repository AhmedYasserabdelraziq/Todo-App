import 'package:flutter/material.dart';

class TasksViewModel extends ChangeNotifier {
  int currentNum = 0;

  void currentIndex(int index) {
    currentNum = index;
    notifyListeners();
  }
}
