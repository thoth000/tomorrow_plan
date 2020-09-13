import 'package:flutter/material.dart';

class BottomBarController with ChangeNotifier {
  int index = 0;
  void changeIndex(int next) {
    index = next;
    notifyListeners();
  }
}
