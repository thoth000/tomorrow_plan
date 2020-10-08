import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomorrow_plan/controller/color_controller.dart';
import 'package:tomorrow_plan/controller/record_controller.dart';
import 'package:tomorrow_plan/ui/parts/action_sheet.dart';
import 'package:tomorrow_plan/ui/parts/date_dialog.dart';
import 'package:tomorrow_plan/ui/parts/rename_sheet.dart';

class TomorrowBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RecordController recordController =
        Provider.of<RecordController>(context);
    final ColorController colorController =
        Provider.of<ColorController>(context);
    final List tomorrowPlan =
        recordController.events[recordController.today.add(
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
                .difference(recordController.today.add(Duration(days: 1)))
                .isNegative);
        final Color borderColor = isDateNotOver
            ? colorController.borderColor
            : colorController.redBorderColor;
        final Color iconColor = isDateNotOver
            ? colorController.iconColor
            : colorController.redIconColor;
        final Color circleColor = isDateNotOver
            ? colorController.circleColor
            : colorController.redCircleColor;
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
                child: recordController.isEditing
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
                        : const SizedBox(),
              ),
            ),
            title: Text(
              event['title'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20,
                color: colorController.textColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            enabled: !colorController.isAnimation,
            onTap: () async {
              if (recordController.isEditing) {
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
                await colorController.hideWidget();
                await recordController.finishPlan(index, 'tomorrow');
                await colorController.appearWidget();
              } else {
                await colorController.hideWidget();
                await recordController.unfinishPlan(index, 'tomorrow');
                await colorController.appearWidget();
              }
            },
            onLongPress: () {
              if (recordController.isEditing) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => RenameSheet(
                    index: index,
                    beforeTitle: event['title'],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                );
              } else {
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
                    selectedDate: recordController.today.add(Duration(days: 1)),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
