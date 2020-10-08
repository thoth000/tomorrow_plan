import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomorrow_plan/controller/bottom_bar_controller.dart';
import 'package:tomorrow_plan/ui/pages/record/record_app_bar.dart';
import 'package:tomorrow_plan/ui/pages/record/record_calendar.dart';
import 'package:tomorrow_plan/ui/pages/today/today_app_bar.dart';
import 'package:tomorrow_plan/ui/pages/today/today_body.dart';
import 'package:tomorrow_plan/ui/pages/tomorrow/tomorrow_app_bar.dart';
import 'package:tomorrow_plan/ui/pages/tomorrow/tomorrow_body.dart';
import 'package:tomorrow_plan/ui/parts/my_bottom_navigation_bar.dart';
import 'package:tomorrow_plan/ui/parts/my_floating_action_button.dart';

class MyHomePage extends StatelessWidget {
  final List<Widget> appBars = [
    TodayAppBar(),
    TomorrowAppBar(),
    RecordAppBar(),
  ];
  final List<Widget> bodies = [
    TodayBody(),
    TomorrowBody(),
    RecordCalendar(),
  ];
  @override
  Widget build(BuildContext context) {
    final int pageIndex = Provider.of<BottomBarController>(context).index;
    return Scaffold(
      appBar: appBars[pageIndex],
      body: bodies[pageIndex],
      bottomNavigationBar: MyBottomNivigationBar(),
      floatingActionButton: MyFloatingActionButton(),
    );
  }
}
