import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:tomorrow_plan/controller/bottom_bar_controller.dart';
import 'package:tomorrow_plan/controller/color_controller.dart';
import 'package:tomorrow_plan/controller/record_controller.dart';
import 'package:tomorrow_plan/ui/home.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomBarController>(
          create: (_) => BottomBarController(),
        ),
        ChangeNotifierProvider<RecordController>(
          create: (_) => RecordController(),
        ),
        ChangeNotifierProvider<ColorController>(
          create: (_) => ColorController(),
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
    await Hive.openBox('setting');
    await Hive.openBox('event');
  }

  Future firstOpen(DateTime today) async {
    if (!Hive.box('setting').containsKey('version')) {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final Map<DateTime, List<Map<String, dynamic>>> e = {};
      await Hive.box('setting').put('version', packageInfo.version);
      await Hive.box('event').put('event', e);
    }
  }

  Future getData(DateTime today) async {
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
