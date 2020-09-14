import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tomorrow_plan/controller/record_controller.dart';
import 'package:tomorrow_plan/ui/pages/record/event_list.dart';

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
            },
          ),
          Expanded(
            child: EventList(),
          ),
        ],
      ),
    );
  }
}
