import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomorrow_plan/controller/bottom_bar_controller.dart';
import 'package:tomorrow_plan/controller/record_controller.dart';

class MyBottomNivigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int pageIndex = Provider.of<BottomBarController>(context).index;
    final BottomBarController bottomBarController =
        Provider.of<BottomBarController>(context, listen: false);
    final RecordController recordController =
        Provider.of<RecordController>(context, listen: false);
    return BottomAppBar(
      child: Row(
        children: [
          Expanded(
            child: FlatButton(
              splashColor: Colors.black12,
              highlightColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                ),
                width: MediaQuery.of(context).size.width / 3.01,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: pageIndex == 0
                      ? const Color(0xFF5C6BC0)
                      : Colors.transparent,
                ),
                child: Text(
                  "今日",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: pageIndex == 0
                        ? const Color(0xFFFFFFFF)
                        : const Color(0xFF5C6BC0),
                  ),
                ),
              ),
              onPressed: () {
                if (pageIndex != 0) {
                  recordController.reset();
                }
                bottomBarController.changeIndex(0);
              },
            ),
          ),
          Expanded(
            child: FlatButton(
              splashColor: Colors.black12,
              highlightColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                ),
                width: MediaQuery.of(context).size.width / 3.01,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: pageIndex == 1
                      ? const Color(0xFF5C6BC0)
                      : Colors.transparent,
                ),
                child: Text(
                  "明日",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: pageIndex == 1
                        ? const Color(0xFFFFFFFF)
                        : const Color(0xFF5C6BC0),
                  ),
                ),
              ),
              onPressed: () {
                if (pageIndex != 1) {
                  recordController.reset();
                }
                bottomBarController.changeIndex(1);
              },
            ),
          ),
          Expanded(
            child: FlatButton(
              splashColor: Colors.black12,
              highlightColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                ),
                width: MediaQuery.of(context).size.width / 3.01,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: pageIndex == 2
                      ? const Color(0xFF5C6BC0)
                      : Colors.transparent,
                ),
                child: Text(
                  "記録",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: pageIndex == 2
                        ? const Color(0xFFFFFFFF)
                        : const Color(0xFF5C6BC0),
                  ),
                ),
              ),
              onPressed: () {
                if (pageIndex != 2) {
                  recordController.reset();
                }
                bottomBarController.changeIndex(2);
              },
            ),
          ),
        ],
      ),
    );
  }
}
