import 'package:flutter/material.dart';

class TodayController with ChangeNotifier{
  List<Map<String,dynamic>> todayPlan;

  void addPlan(String title){
    final Map<String,dynamic> _event = {"title":title,"isFinish":false};
    todayPlan.insert(0,_event);
    notifyListeners();
  }

  void removePlan(int index){
    todayPlan.removeAt(index);
    notifyListeners();
  }

  void finish(int index){
    todayPlan[index]["isFinish"]=true;
    eventSort();
    notifyListeners();
  }

  void unfinish(int index){
    todayPlan[index]["isFinish"]=false;
    eventSort();
    notifyListeners();
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
}