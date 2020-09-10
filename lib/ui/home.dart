import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tomorrow_plan/controller/bottom_bar_controller.dart';
import 'package:tomorrow_plan/ui/pages/record/record_calendar.dart';
import 'package:tomorrow_plan/ui/parts/my_bottom_navigation_bar.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> bodies = [
    Container(
      child:Center(child: Text("今日"),),
    ),
    Container(
      child:Center(child: Text("明日"),),
    ),
    RecordCalendar(),
  ];
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
    final int index = Provider.of<BottomBarController>(context).index;
    return Scaffold(
      body: bodies[index],
      bottomNavigationBar: MyBottomNivigationBar(),
    );
  }
}
