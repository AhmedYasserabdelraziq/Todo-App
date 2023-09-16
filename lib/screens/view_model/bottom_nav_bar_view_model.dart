import 'package:flutter/material.dart';

class BottomNavBarViewModel extends ChangeNotifier {
  int currentNum = 0;

  void currentIndex(int index) {
    currentNum = index;
    notifyListeners();
  }
}
