import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tomorrow_plan/controller/record_controller.dart';

class RecordCalendar extends StatefulWidget {
  @override
  _RecordCalendarState createState() => _RecordCalendarState();
}

class _RecordCalendarState extends State<RecordCalendar> {
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<RecordController>(context);
    Map<DateTime, List> events = controller.events;
    if (events == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return SafeArea(
      child: Column(
        children: [
          TableCalendar(
              calendarController: _calendarController,
              events: events,
              builders: CalendarBuilders(
                markersBuilder: (context, date, _, holidays) {
                  bool isMark = false;
                  if (events[date].length == 0) {
                    return [
                      Container(),
                    ];
                  }
                  for (Map event in events[date]) {
                    if (!event['isFinish']) {
                      isMark = true;
                      break;
                    }
                  }
                  if (isMark) {
                    return [
                      Container(
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.blueGrey[700],
                            width: 2,
                          ),
                          color: Colors.white,
                        ),
                      )
                    ];
                  }
                  return [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blueGrey[300],
                      ),
                    )
                  ];
                },
              ),
              onDaySelected: (day, events) {
                Provider.of<RecordController>(context, listen: false)
                    .selectDate(day);
              }),
          Expanded(
            child: EventList(),
          ),
        ],
      ),
    );
  }
}

class EventList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<RecordController>(context);
    DateTime selectedDate = controller.selectedDate;
    Map<DateTime, List> events = controller.events;
    if (events[selectedDate] == null) {
      return Center(
        child: Text('記録なし'),
      );
    }
    return ListView.builder(
      itemCount: events[selectedDate].length,
      itemBuilder: (context, index) {
        final event = events[selectedDate][index];
        return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.grey),
            borderRadius: BorderRadius.circular(12.0),
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 4.0,
          ),
          child: ListTile(
            leading: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(500),
                border: Border.all(
                  width: 3,
                  color: const Color(0xFF5C6BC0),
                ),
              ),
              child: Center(
                child: event['isFinish']
                    ? Icon(
                        Icons.check,
                        size: 30,
                        color: const Color(0xFF5C6BC0),
                      )
                    : SizedBox(),
              ),
            ),
            title: Text(
              event['title'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () {
              if (!event['isFinish']) {
                controller.finish(index);
                //for snackBar
                List<String> messages = [
                  'お疲れ様でした！',
                  '頑張りました！',
                  'この調子です！',
                  'えらい！',
                  'さすがです！'
                ];
                Random random = new Random();
                int randomNumber = random.nextInt(5);
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(messages[randomNumber]),
                    duration: Duration(seconds: 1),
                  ),
                );
              } else {
                controller.unfinish(index);
              }
            },
          ),
        );
      },
    );
  }
}
