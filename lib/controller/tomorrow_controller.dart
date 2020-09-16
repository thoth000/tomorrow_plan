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

  void addPlan(Map event) {
    tomorrowPlan.add(event);
    notifyListeners();
    setPlan();
  }

  Map removePlan(int index) {
    final Map map = tomorrowPlan.removeAt(index);
    notifyListeners();
    setPlan();
    return map;
  }
}
