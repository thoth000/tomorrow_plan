import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class RecordController with ChangeNotifier {
  DateTime selectedDate;
  Map<DateTime, List> events;
  bool isRemoving = false;

  Future getPlan(DateTime today) async {
    final Map savedData = await Hive.lazyBox('event').get('event');
    events = new Map<DateTime, List>.from(savedData);
    selectedDate = today;
    notifyListeners();
  }

  void setPlan() {
    Hive.lazyBox('event').put('event', events);
  }

  void eventSort(DateTime date) {
    events[date].sort((a, b) {
      if (b['isFinish']) {
        return -1;
      } else {
        return 1;
      }
    });
    notifyListeners();
  }

  void selectDate(DateTime day) {
    final DateTime date = DateTime(day.year, day.month, day.day);
    selectedDate = date;
    notifyListeners();
  }

  void finishPlan(int index) {
    events[selectedDate][index]['isFinish'] = true;
    eventSort(selectedDate);
    setPlan();
  }

  void unfinishPlan(int index) {
    events[selectedDate][index]['isFinish'] = false;
    eventSort(selectedDate);
    setPlan();
  }

  void switchMode() {
    isRemoving = !isRemoving;
    notifyListeners();
  }

  void resetMode() {
    isRemoving = false;
    notifyListeners();
  }

  void removePlan(int index) {
    events[selectedDate].removeAt(index);
    notifyListeners();
    setPlan();
  }
}
