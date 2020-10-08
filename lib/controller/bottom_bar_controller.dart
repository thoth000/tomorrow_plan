import 'package:flutter/material.dart';

class BottomBarController with ChangeNotifier {
  int index = 0;
  void changeIndex(int nextIndex) {
    index = nextIndex;
    notifyListeners();
  }
}
