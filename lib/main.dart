import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomorrow_plan/controller/bottom_bar_controller.dart';
import 'package:tomorrow_plan/controller/record_controller.dart';
import 'package:tomorrow_plan/controller/today_controller.dart';
import 'package:tomorrow_plan/controller/tomorrow_controller.dart';
import 'package:tomorrow_plan/ui/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomBarController>(
          create: (_) => BottomBarController(),
        ),
        ChangeNotifierProvider<TodayController>(
          create: (_) => TodayController(),
        ),
        ChangeNotifierProvider<TomorrowController>(
          create: (_) => TomorrowController(),
        ),
        ChangeNotifierProvider<RecordController>(
          create: (_) => RecordController(),
        ),
      ],
      child: MaterialApp(
        title: 'TomorrowPlan',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
    );
  }
}
