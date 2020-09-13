import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:tomorrow_plan/controller/bottom_bar_controller.dart';
import 'package:tomorrow_plan/controller/record_controller.dart';
import 'package:tomorrow_plan/controller/today_controller.dart';
import 'package:tomorrow_plan/controller/tomorrow_controller.dart';
import 'package:tomorrow_plan/ui/home.dart';

void main() {
  runApp(
    MultiProvider(
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
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future readyHive() async {
    await Hive.initFlutter();
    await Hive.openBox('plan');
    await Hive.openBox('setting');
    await Hive.openLazyBox('event');
  }

  Future firstOpen(DateTime today) async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if (!Hive.box('setting').containsKey('version')) {
      final Map<DateTime, List<Map<String, dynamic>>> e = {};
      final DateTime tomorrow = today.add(Duration(days: 1));
      await Hive.box('setting').put('version', packageInfo.version);
      await Hive.box('setting').put('today', today);
      await Hive.box('setting').put('tomorrow', tomorrow);
      await Hive.box('plan').put('todayPlan', []);
      await Hive.box('plan').put('tomorrowPlan', []);
      await Hive.lazyBox('event').put('event', e);
    }
  }

  Future regularCheck(DateTime today) async {
    if (today != Hive.box('setting').get('today')) {
      final DateTime savedToday = await Hive.box('setting').get('today');
      final DateTime savedTomorrow = await Hive.box('setting').get('tomorrow');
      final List todayPlan = Hive.box('plan').get('todayPlan');
      final Map event = await Hive.lazyBox('event').get('event');
      event[savedToday] = todayPlan;
      //
      final List tomorrowPlan = Hive.box('plan').get('tomorrowPlan');
      if (today.difference(savedToday).inDays == 1) {
        await Hive.box('plan').put('todayPlan', tomorrowPlan);
      } else {
        await Hive.box('plan').put('todayPlan', []);
        event[savedTomorrow] = tomorrowPlan;
      }
      //
      await Hive.box('plan').put('tomorrowPlan', []);
      await Hive.lazyBox('event').put('event', event);
      await Hive.box('setting').put('today', today);
      await Hive.box('setting').put(
        'tomorrow',
        today.add(Duration(days: 1)),
      );
    }
  }

  Future getData(DateTime today) async {
    await Provider.of<TodayController>(context, listen: false).getPlan();
    await Provider.of<TomorrowController>(context, listen: false).getPlan();
    await Provider.of<RecordController>(context, listen: false).getPlan(today);
  }

  @override
  void initState() {
    super.initState();
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    Future(() async {
      await readyHive();
      await firstOpen(today);
      await regularCheck(today);
      await getData(today);
    });
  }

  @override
  void dispose() {
    super.dispose();
    Hive.close();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tomorrow_plan',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'NotoSansJP',
      ),
      home: MyHomePage(),
    );
  }
}
