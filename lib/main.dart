import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomorrow_plan/controller/bottom_bar_controller.dart';
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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
    );
  }
}
