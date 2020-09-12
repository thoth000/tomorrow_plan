import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TomorrowController with ChangeNotifier {
  List tomorrowPlan;

  Future getPlan() async {
    tomorrowPlan = await Hive.box('plan').get('tomorrowPlan');
    notifyListeners();
  }

  void setPlan() {
    Hive.box('plan').put('tomorrowPlan', tomorrowPlan);
  }

  void addPlan(String title) {
    final Map<String, dynamic> _event = {"title": title, "isFinish": false};
    tomorrowPlan.insert(0, _event);
    notifyListeners();
    setPlan();
  }

  void removePlan(int index) {
    tomorrowPlan.removeAt(index);
    notifyListeners();
    setPlan();
  }
}
