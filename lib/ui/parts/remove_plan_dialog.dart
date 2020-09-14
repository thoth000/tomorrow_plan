import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomorrow_plan/controller/bottom_bar_controller.dart';
import 'package:tomorrow_plan/controller/record_controller.dart';
import 'package:tomorrow_plan/controller/today_controller.dart';
import 'package:tomorrow_plan/controller/tomorrow_controller.dart';

class RemovePlanDialog extends StatelessWidget {
  RemovePlanDialog({this.planIndex});
  final int planIndex;
  @override
  Widget build(BuildContext context) {
    final int pageIndex = Provider.of<BottomBarController>(context).index;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text('削除'),
      content: Text(pageIndex != 2 ? '予定を削除しますか？' : '記録を削除しますか？'),
      actions: [
        FlatButton(
          child: const Text('いいえ'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: const Text('はい'),
          onPressed: () {
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
