import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomorrow_plan/controller/bottom_bar_controller.dart';
import 'package:tomorrow_plan/controller/record_controller.dart';
import 'package:tomorrow_plan/controller/today_controller.dart';
import 'package:tomorrow_plan/controller/tomorrow_controller.dart';

class ActionSheet extends StatelessWidget {
  ActionSheet({this.planIndex});
  final int planIndex;
  @override
  Widget build(BuildContext context) {
    int pageIndex = Provider.of<BottomBarController>(context).index;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(10),
          height: 8,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(500),
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        (pageIndex != 0)
            ? ListTile(
                leading: Icon(
                  Icons.calendar_today,
                  size: 50,
                  color: const Color(0xFF5C6BC0),
                ),
                title: Text(
                  " 今日の予定に移動させる",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                contentPadding: EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                  left: 16,
                ),
                onTap: () {
                  Map event;
                  if (pageIndex == 1) {
                    event =
                        Provider.of<TomorrowController>(context, listen: false)
                            .removePlan(planIndex);
                  } else {
                    event =
                        Provider.of<RecordController>(context, listen: false)
                            .removePlan(planIndex);
                  }
                  Provider.of<TodayController>(context, listen: false)
                      .addPlan(event);
                  Navigator.pop(context);
                },
              )
            : Container(),
        (pageIndex != 1)
            ? ListTile(
                leading: Icon(
                  Icons.date_range,
                  size: 50,
                  color: const Color(0xFF5C6BC0),
                ),
                title: Text(
                  " 明日の予定に移動させる",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                contentPadding: EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                  left: 16,
                ),
                onTap: () {
                  Map event;
                  if (pageIndex == 0) {
                    event = Provider.of<TodayController>(context, listen: false)
                        .removePlan(planIndex);
                  } else {
                    event =
                        Provider.of<RecordController>(context, listen: false)
                            .removePlan(planIndex);
                  }
                  Provider.of<TomorrowController>(context, listen: false)
                      .addPlan(event);
                  Navigator.pop(context);
                },
              )
            : Container(),
        ListTile(
          leading: Icon(
            Icons.cancel,
            size: 50,
            color: Colors.red,
          ),
          title: Text(
            " 予定を削除する",
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          contentPadding: EdgeInsets.only(
            top: 8,
            bottom: 8,
            left: 16,
          ),
          onTap: () {
            if (pageIndex == 0) {
              Provider.of<TodayController>(context, listen: false)
                  .removePlan(planIndex);
            } else if (pageIndex == 1) {
              Provider.of<TomorrowController>(context, listen: false)
                  .removePlan(planIndex);
            } else {
              Provider.of<RecordController>(context, listen: false)
                  .removePlan(planIndex);
            }
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
