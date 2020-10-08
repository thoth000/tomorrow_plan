import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vibration/vibration.dart';

class RecordController with ChangeNotifier {
  DateTime selectedDate;
  DateTime today = DateTime.now();
  Map<DateTime, List> events = {};
  bool isEditing = false;

  Future getPlan(DateTime _today) async {
    final Map savedData = await Hive.box('event').get('event');
    events = new Map<DateTime, List>.from(savedData);
    selectedDate = _today;
    today = _today;
    notifyListeners();
  }

  Future<void> setPlan() async {
    await Hive.box('event').put('event', events);
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
    final DateTime _date = DateTime(day.year, day.month, day.day);
    selectedDate = _date;
    notifyListeners();
  }

  Future finishPlan(int index, String pattern) async {
    DateTime _date = selectedDate;
    if (pattern == "today") {
      _date = today;
    } else if (pattern == "tomorrow") {
      _date = today.add(Duration(days: 1));
    }
    Vibration.vibrate(duration: 50);
    events[_date][index]['isFinish'] = true;
    eventSort(_date);
    setPlan();
  }

  Future unfinishPlan(int index, String pattern) async {
    DateTime _date = selectedDate;
    if (pattern == "today") {
      _date = today;
    } else if (pattern == "tomorrow") {
      _date = today.add(Duration(days: 1));
    }
    events[_date][index]['isFinish'] = false;
    eventSort(_date);
    setPlan();
  }

  void switchMode() {
    isEditing = !isEditing;
    notifyListeners();
  }

  void reset() {
    isEditing = false;
    selectedDate = today;
    notifyListeners();
  }

  Future<void> rename(int index, String newTitle, String pattern) async {
    DateTime _date = selectedDate;
    if (pattern == "today") {
      _date = today;
    } else if (pattern == "tomorrow") {
      _date = today.add(Duration(days: 1));
    }
    events[_date][index]['title'] = newTitle;
    notifyListeners();
    setPlan();
  }

  void addPlan(Map event, String pattern) {
    DateTime _date = selectedDate;
    if (pattern == "today") {
      _date = today;
    } else if (pattern == "tomorrow") {
      _date = today.add(Duration(days: 1));
    }
    if (events[_date] == null) {
      events[_date] = [];
    }
    events[_date].add(event);
    eventSort(_date);
    notifyListeners();
    setPlan();
  }

  Map removePlan(int index, String pattern) {
    DateTime _date = selectedDate;
    if (pattern == "today") {
      _date = today;
    } else if (pattern == "tomorrow") {
      _date = today.add(Duration(days: 1));
    }
    final map = events[_date].removeAt(index);
    notifyListeners();
    setPlan();
    return map;
  }

  Future<void> resetData() async {
    events = {};
    notifyListeners();
    await setPlan();
  }
}
