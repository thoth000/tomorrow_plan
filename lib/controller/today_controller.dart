import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TodayController with ChangeNotifier {
  List todayPlan;

  bool isEditing = false;

  Future getPlan() async {
    todayPlan = await Hive.box('plan').get('todayPlan');
    eventSort();
    notifyListeners();
  }

  void setPlan() {
    Hive.box('plan').put('todayPlan', todayPlan);
  }

  void addPlan(Map event) {
    todayPlan.add(event);
    eventSort();
    notifyListeners();
    setPlan();
  }

  Map removePlan(int index) {
    final map = todayPlan.removeAt(index);
    notifyListeners();
    setPlan();
    return map;
  }

  void finishPlan(int index) {
    todayPlan[index]["isFinish"] = true;
    eventSort();
    notifyListeners();
    setPlan();
  }

  void unfinishPlan(int index) {
    todayPlan[index]["isFinish"] = false;
    eventSort();
    notifyListeners();
    setPlan();
  }

  void eventSort() {
    todayPlan.sort((a, b) {
      if (b['isFinish']) {
        return -1;
      } else {
        return 1;
      }
    });
  }

  void switchMode() {
    isEditing = !isEditing;
    notifyListeners();
  }

  void resetMode() {
    isEditing = false;
    notifyListeners();
  }
}
