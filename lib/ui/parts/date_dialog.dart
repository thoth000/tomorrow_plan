import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateDialog extends StatelessWidget {
  DateDialog({
    @required this.title,
    @required this.planDate,
    @required this.selectedDate,
  });
  final String title;
  final DateTime planDate;
  final DateTime selectedDate;
  @override
  Widget build(BuildContext context) {
    String text;
    if (planDate == null) {
      text = '予定日時がないToDoです。';
    } else {
      final String date = DateFormat('y/M/d').format(planDate);
      final int dayago = selectedDate.difference(planDate).inDays;
      String day = 'です。';
      if (dayago > 0) {
        day = '\n$dayago日過ぎています。';
      }
      text = '予定日時は$date$day';
    }
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(title),
      content: Text('$text'),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'OK',
          ),
        ),
      ],
    );
  }
}
