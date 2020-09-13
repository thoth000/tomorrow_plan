import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TodayController with ChangeNotifier {
  List todayPlan;

  bool isRemoving = false;

  Future getPlan() async {
    todayPlan = await Hive.box('plan').get('todayPlan');
    notifyListeners();
  }

  void setPlan() {
    Hive.box('plan').put('todayPlan', todayPlan);
  }

  void addPlan(String title) {
    final Map<String, dynamic> _event = {"title": title, "isFinish": false};
    todayPlan.insert(0, _event);
    notifyListeners();
    setPlan();
  }

  void removePlan(int index) {
    todayPlan.removeAt(index);
    notifyListeners();
    setPlan();
  }

  void finish(int index) {
    todayPlan[index]["isFinish"] = true;
    eventSort();
    notifyListeners();
    setPlan();
  }

  void unfinish(int index) {
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

  void modeChange(){
    isRemoving = !isRemoving;
    notifyListeners();
  }
}
