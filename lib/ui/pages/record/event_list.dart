import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tomorrow_plan/controller/record_controller.dart';
import 'package:tomorrow_plan/ui/parts/action_sheet.dart';

class EventList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<RecordController>(context);
    DateTime selectedDate = controller.selectedDate;
    Map<DateTime, List> events = controller.events;
    if (events[selectedDate] == null || events[selectedDate].length == 0) {
      if (selectedDate.difference(controller.today).inDays >= 0) {
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
              color: controller.borderColor,
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
                  color: controller.circleColor,
                ),
              ),
              child: Center(
                child: controller.isEditing
                    ? Icon(
                        Icons.remove,
                        color: controller.iconColor,
                        size: 35,
                      )
                    : event['isFinish']
                        ? Icon(
                            Icons.check,
                            size: 30,
                            color: controller.iconColor,
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
                controller.finishPlan(index, 'normal');
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
              } else {
                controller.unfinishPlan(index, 'normal');
              }
            },
          ),
        );
      },
    );
  }
}
