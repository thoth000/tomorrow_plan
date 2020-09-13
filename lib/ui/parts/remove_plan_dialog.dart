import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomorrow_plan/controller/bottom_bar_controller.dart';
import 'package:tomorrow_plan/controller/today_controller.dart';
import 'package:tomorrow_plan/controller/tomorrow_controller.dart';

class RemovePlanDialog extends StatelessWidget {
  RemovePlanDialog({this.planIndex});
  final int planIndex;
  @override
  Widget build(BuildContext context) {
    final int index = Provider.of<BottomBarController>(context).index;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text('削除'),
      content: Text('予定を削除しますか？'),
      actions: [
        FlatButton(
          child: Text('いいえ'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text('はい'),
          onPressed: () {
            if (index == 0) {
              Provider.of<TodayController>(context, listen: false)
                  .removePlan(planIndex);
            } else {
              Provider.of<TomorrowController>(context, listen: false)
                  .removePlan(planIndex);
            }
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
