import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomorrow_plan/controller/bottom_bar_controller.dart';

class MyBottomNivigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int index = Provider.of<BottomBarController>(context).index;
    return BottomAppBar(
      child: Row(
        children: [
          Expanded(
            child: FlatButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                ),
                width: MediaQuery.of(context).size.width / 3.01,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:
                      index == 0 ? const Color(0xFF5C6BC0) : Colors.transparent,
                ),
                child: Text(
                  "今日",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: index == 0
                        ? const Color(0xFFFFFFFF)
                        : const Color(0xFF5C6BC0),
                  ),
                ),
              ),
              onPressed: () {
                Provider.of<BottomBarController>(context, listen: false)
                    .changeIndex(0);
              },
            ),
          ),
          Expanded(
            child: FlatButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                ),
                width: MediaQuery.of(context).size.width / 3.01,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:
                      index == 1 ? const Color(0xFF5C6BC0) : Colors.transparent,
                ),
                child: Text(
                  "明日",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: index == 1
                        ? const Color(0xFFFFFFFF)
                        : const Color(0xFF5C6BC0),
                  ),
                ),
              ),
              onPressed: () {
                Provider.of<BottomBarController>(context, listen: false)
                    .changeIndex(1);
              },
            ),
          ),
          Expanded(
            child: FlatButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                ),
                width: MediaQuery.of(context).size.width / 3.01,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:
                      index == 2 ? const Color(0xFF5C6BC0) : Colors.transparent,
                ),
                child: Text(
                  "記録",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: index == 2
                        ? const Color(0xFFFFFFFF)
                        : const Color(0xFF5C6BC0),
                  ),
                ),
              ),
              onPressed: () {
                Provider.of<BottomBarController>(context, listen: false)
                    .changeIndex(2);
              },
            ),
          ),
        ],
      ),
    );
  }
}
