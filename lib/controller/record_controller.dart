import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class RecordController with ChangeNotifier {

  DateTime selectedDate;
  Map events;


  Future getPlan(DateTime today) async {
    final savedData = await Hive.lazyBox('event').get('event');
    events = new Map<DateTime,List<Map<String,dynamic>>>.from(savedData);
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
    final DateTime date = DateTime(day.year,day.month,day.day);
    selectedDate = date;
    notifyListeners();
  }

  void finish(int index) {
    events[selectedDate][index]['isFinish'] = true;
    eventSort(selectedDate);
    setPlan();
  }

  void unfinish(int index) {
    events[selectedDate][index]['isFinish'] = false;
    eventSort(selectedDate);
    setPlan();
  }
}
