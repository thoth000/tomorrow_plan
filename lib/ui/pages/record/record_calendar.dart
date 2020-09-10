import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class RecordCalendar extends StatefulWidget {
  @override
  _RecordCalendarState createState() => _RecordCalendarState();
}

class _RecordCalendarState extends State<RecordCalendar>
    with TickerProviderStateMixin {
  Map<DateTime, List> events;

  DateTime selectDate = DateTime.now();

  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    events = {
      selectDate: [
        {"title": "event", "done": true},
        {"title": "俺が王", "done": false},
      ],
    };
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          TableCalendar(
            calendarController: _calendarController,
            events: events,
            builders: CalendarBuilders(
              markersBuilder: (context, date, _, holidays) {
                bool isMark = false;
                for (var _event in events[date]) {
                  if (!_event["done"]) {
                    isMark = true;
                    break;
                  }
                }
                if (isMark) {
                  return [Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                  )];
                }
                return [Container()];
              },
            ),
          ),
          Expanded(
            child: _buildEventList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: events[selectDate]
          .map(
            (event) => Container(
              decoration: BoxDecoration(
                border: Border.all(width: 2),
                borderRadius: BorderRadius.circular(12.0),
              ),
              margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: ListTile(
                title: Text(
                  event["title"].toString(),
                ),
                subtitle: Text(event["done"]?"完了済み":"未完了"),
                onTap: () => print('${event["title"]} tapped!'),
              ),
            ),
          )
          .toList(),
    );
  }
}
