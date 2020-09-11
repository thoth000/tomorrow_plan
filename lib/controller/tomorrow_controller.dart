import 'package:flutter/material.dart';

class TomorrowController with ChangeNotifier {
  List<Map<String, dynamic>> tomorrowPlan;

  void addPlan(String title) {
    final Map<String, dynamic> _event = {"title": title, "isFinish": false};
    tomorrowPlan.insert(0, _event);
    notifyListeners();
  }

  void removePlan(int index) {
    tomorrowPlan.removeAt(index);
    notifyListeners();
  }
}
