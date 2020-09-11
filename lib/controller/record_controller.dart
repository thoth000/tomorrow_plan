import 'package:flutter/material.dart';

class RecordController with ChangeNotifier {
  RecordController() {
    selectedDate = DateTime(2020, 9, 11);
    events = {
      selectedDate: [
        {"title": "aaa", "isFinish": false},
        {"title": "bbb", "isFinish": true},
        {"title": "ccc", "isFinish": true},
      ],
      selectedDate.subtract(Duration(days: 1)): [
        {"title": "ccc", "isFinish": false},
        {"title": "ddd", "isFinish": true},
      ],
      selectedDate.subtract(Duration(days: 2)): [
        {"title": "eee", "isFinish": false},
        {"title": "fff", "isFinish": true},
      ],
    };
    notifyListeners();
  }
  DateTime selectedDate;
  Map<DateTime, List<Map<String, dynamic>>> events;

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
  }

  void unfinish(int index) {
    events[selectedDate][index]['isFinish'] = false;
    eventSort(selectedDate);
  }
}
