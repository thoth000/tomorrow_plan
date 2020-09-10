import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomorrow_plan/controller/bottom_bar_controller.dart';

class MyBottomNivigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int index = Provider.of<BottomBarController>(context).index;
    return BottomNavigationBar(
      currentIndex: index,
      selectedItemColor: Colors.blue,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: Text(
            "今日",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: index==0?const Color(0xFF5C6BC0):null,
            ),
          ),
          title: Text(''),
        ),
        BottomNavigationBarItem(
          icon: Text(
            "明日",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: index==1?const Color(0xFF5C6BC0):null,
            ),
          ),
          title: Text(''),
        ),
        BottomNavigationBarItem(
          icon: Text(
            "記録",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: index==2?const Color(0xFF5C6BC0):null,
            ),
          ),
          title: Text(''),
        ),
      ],
      onTap: (next) {
        Provider.of<BottomBarController>(context, listen: false)
            .changeIndex(next);
      },
    );
  }
}
