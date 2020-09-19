import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vibration/vibration.dart';

class RecordController with ChangeNotifier {
  DateTime selectedDate;
  DateTime today = DateTime.now();
  Map<DateTime, List> events = {};
  bool isEditing = false;
  //animation用
  Color borderColor = Colors.grey;
  Color circleColor = const Color(0xFF5C6BC0);
  Color iconColor = const Color(0xFF5C6BC0);
  Color textColor = Colors.black;

  Future hideWidget() async {
    borderColor = Colors.white;
    circleColor = Colors.white;
    for (int i = 0; i <= 10; i += 2) {
      textColor = Colors.black.withOpacity(1 - i / 10);
      iconColor = const Color(0xFF5C6BC0).withOpacity(1 - i / 10);
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 40));
    }
    await Future.delayed(Duration(milliseconds: 30));
  }

  Future appearWidget() async {
    borderColor = Colors.grey;
    circleColor = const Color(0xFF5C6BC0);
    notifyListeners();
    for (int i = 10; i >= 0; i -= 2) {
      textColor = Colors.black.withOpacity(1 - i / 10);
      iconColor = const Color(0xFF5C6BC0).withOpacity(1 - i / 10);
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 40));
    }
  }

  Future getPlan(DateTime _today) async {
    final Map savedData = await Hive.box('event').get('event');
    events = new Map<DateTime, List>.from(savedData);
    selectedDate = _today;
    today = _today;
    notifyListeners();
  }

  void setPlan() {
    Hive.box('event').put('event', events);
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
    Vibration.vibrate(duration: 60);
    await hideWidget();
    events[_date][index]['isFinish'] = true;
    eventSort(_date);
    appearWidget();
    setPlan();
  }

  Future unfinishPlan(int index, String pattern) async {
    DateTime _date = selectedDate;
    if (pattern == "today") {
      _date = today;
    } else if (pattern == "tomorrow") {
      _date = today.add(Duration(days: 1));
    }
    await hideWidget();
    events[_date][index]['isFinish'] = false;
    eventSort(_date);
    appearWidget();
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
    DateTime date = selectedDate;
    if (pattern == "today") {
      date = today;
    } else if (pattern == "tomorrow") {
      date = today.add(Duration(days: 1));
    }
    final map = events[date].removeAt(index);
    notifyListeners();
    setPlan();
    return map;
  }
}
