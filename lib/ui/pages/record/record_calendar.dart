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
    Map events = controller.events;
    return SafeArea(
      child: Column(
        children: [
          TableCalendar(
              calendarController: _calendarController,
              events: events,
              builders: CalendarBuilders(
                markersBuilder: (context, date, _, holidays) {
                  bool isMark=false;
                  for(Map event in events[date]){
                    if(!event['isFinish']){
                      isMark=true;
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
                  return [Container()];
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
    Map<DateTime, List<Map<String, dynamic>>> events = controller.events;
    if (events[selectedDate] == null) {
      print('null');
      return Container();
    }
    return ListView(
      children: events[selectedDate]
          .map(
            (event) => Container(
              decoration: BoxDecoration(
                border: Border.all(width: 2),
                borderRadius: BorderRadius.circular(12.0),
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              child: ListTile(
                title: Text(
                  event['title'],
                ),
                subtitle: Text(event['isFinish'] ? "達成済み" : "未完了"),
                onTap: () => print('${event['title']} tapped!'),
              ),
            ),
          )
          .toList(),
    );
  }
}
