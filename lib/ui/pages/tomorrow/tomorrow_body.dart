import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomorrow_plan/controller/record_controller.dart';
import 'package:tomorrow_plan/ui/parts/action_sheet.dart';
import 'package:tomorrow_plan/ui/parts/date_dialog.dart';

class TomorrowBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<RecordController>(context);
    final tomorrowPlan = controller.events[controller.today.add(
      Duration(days: 1),
    )];
    if (tomorrowPlan == null || tomorrowPlan.length == 0) {
      return Center(child: const Text('明日は何をしますか？'));
    }
    return ListView.builder(
      itemCount: tomorrowPlan.length,
      itemBuilder: (context, index) {
        final event = tomorrowPlan[index];
        final DateTime planDate = event['planDate'];
        final bool isDateNotOver = (planDate == null ||
            !planDate
                .difference(controller.today.add(Duration(days: 1)))
                .isNegative);
        final Color borderColor =
            isDateNotOver ? controller.borderColor : controller.redBorderColor;
        final Color iconColor =
            isDateNotOver ? controller.iconColor : controller.redIconColor;
        final Color circleColor =
            isDateNotOver ? controller.circleColor : controller.redCircleColor;
        return AnimatedContainer(
          duration: Duration(milliseconds: 100),
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 5,
          ),
          child: ListTile(
            leading: AnimatedContainer(
              duration: Duration(milliseconds: 100),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(500),
                border: Border.all(
                  width: 3,
                  color: circleColor,
                ),
              ),
              child: Center(
                child: controller.isEditing
                    ? Icon(
                        Icons.remove,
                        color: iconColor,
                        size: 35,
                      )
                    : event['isFinish']
                        ? Icon(
                            Icons.check,
                            size: 30,
                            color: iconColor,
                          )
                        : SizedBox(),
              ),
            ),
            title: Text(
              event['title'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20,
                color: controller.textColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            enabled: !controller.isAnimation,
            onTap: () {
              if (controller.isEditing) {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  builder: (context) => ActionSheet(
                    planIndex: index,
                  ),
                );
              } else if (!event['isFinish']) {
                controller.finishPlan(index, 'tomorrow');
                //for snackBar
                List<String> messages = [
                  'お疲れ様でした！',
                  '頑張りました！',
                  'この調子です！',
                  'えらい！',
                  'さすがです！'
                ];
                Random random = new Random();
                int randomNumber = random.nextInt(5);
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(messages[randomNumber]),
                    duration: Duration(seconds: 1),
                  ),
                );
                //ここまで
              } else {
                controller.unfinishPlan(index, 'tomorrow');
              }
            },
            onLongPress: () {
              String title;
              if (isDateNotOver) {
                title = '予定通りです';
              } else {
                title = '後回しにしています';
              }
              showDialog(
                context: context,
                builder: (context) => DateDialog(
                  title: title,
                  planDate: planDate,
                  selectedDate: controller.today.add(Duration(days: 1)),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
