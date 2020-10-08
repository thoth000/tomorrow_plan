import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomorrow_plan/controller/color_controller.dart';

import 'package:tomorrow_plan/controller/record_controller.dart';
import 'package:tomorrow_plan/ui/parts/action_sheet.dart';
import 'package:tomorrow_plan/ui/parts/rename_sheet.dart';

class EventList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RecordController recordController =
        Provider.of<RecordController>(context);
    final ColorController colorController =
        Provider.of<ColorController>(context);
    DateTime selectedDate = recordController.selectedDate;
    Map<DateTime, List> events = recordController.events;
    if (events[selectedDate] == null || events[selectedDate].length == 0) {
      if (selectedDate.difference(recordController.today).inDays >= 0) {
        return const Center(
          child: Text('予定はありません'),
        );
      }
      return const Center(
        child: Text('記録はありません'),
      );
    }
    return ListView.builder(
      itemCount: events[selectedDate].length,
      itemBuilder: (context, index) {
        final event = events[selectedDate][index];
        return AnimatedContainer(
          duration: Duration(milliseconds: 100),
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: colorController.borderColor,
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
                  color: colorController.circleColor,
                ),
              ),
              child: Center(
                child: recordController.isEditing
                    ? Icon(
                        Icons.remove,
                        color: colorController.iconColor,
                        size: 35,
                      )
                    : event['isFinish']
                        ? Icon(
                            Icons.check,
                            size: 30,
                            color: colorController.iconColor,
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
                //controller method
                await colorController.hideWidget();
                await recordController.finishPlan(index, 'normal');
                await colorController.appearWidget();
              } else {
                await colorController.hideWidget();
                await recordController.unfinishPlan(index, 'normal');
                await colorController.appearWidget();
              }
            },
            onLongPress: () {
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
            },
          ),
        );
      },
    );
  }
}
