import 'package:flutter/material.dart';

class ColorController with ChangeNotifier {
  bool isAnimation = false;
  Color borderColor = Colors.indigo[300];
  Color redBorderColor = Colors.red[300];
  Color circleColor = const Color(0xFF5C6BC0);
  Color redCircleColor = Colors.red;
  Color iconColor = const Color(0xFF5C6BC0);
  Color redIconColor = Colors.red;
  Color textColor = Colors.black;

  Future hideWidget() async {
    isAnimation = true;
    borderColor = Colors.white;
    redBorderColor = Colors.white;
    circleColor = Colors.white;
    redCircleColor = Colors.white;
    for (int i = 0; i <= 10; i += 2) {
      textColor = Colors.black.withOpacity(1 - i / 10);
      iconColor = const Color(0xFF5C6BC0).withOpacity(1 - i / 10);
      redIconColor = Colors.red.withOpacity(1 - i / 10);
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 20));
    }
    await Future.delayed(Duration(milliseconds: 20));
  }

  Future appearWidget() async {
    borderColor = Colors.indigo[300];
    redBorderColor = Colors.red[300];
    circleColor = const Color(0xFF5C6BC0);
    redCircleColor = Colors.red;
    for (int i = 10; i >= 0; i -= 2) {
      textColor = Colors.black.withOpacity(1 - i / 10);
      iconColor = const Color(0xFF5C6BC0).withOpacity(1 - i / 10);
      redIconColor = Colors.red.withOpacity(1 - i / 10);
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 20));
    }
    isAnimation = false;
    notifyListeners();
  }
}
