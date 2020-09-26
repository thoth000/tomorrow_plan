import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomorrow_plan/controller/record_controller.dart';
import 'package:tomorrow_plan/ui/parts/action_sheet.dart';

class TomorrowBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RecordController controller = Provider.of<RecordController>(context);
    final List tomorrowPlan =
        controller.events[controller.today.add(Duration(days: 1))];
    if (tomorrowPlan == null) {
      return Container();
    }
    return ListView.builder(
      itemCount: tomorrowPlan.length,
      itemBuilder: (context, index) {
        final event = tomorrowPlan[index];
        return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.grey),
            borderRadius: BorderRadius.circular(12.0),
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 5,
          ),
          child: ListTile(
            leading: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(500),
                border: Border.all(
                  width: 3,
                  color: const Color(0xFF5C6BC0),
                ),
              ),
              child: Center(
                child: controller.isEditing
                    ? const Icon(
                        Icons.remove,
                        color: Color(0xFF5C6BC0),
                        size: 35,
                      )
                    : event['isFinish']
                        ? const Icon(
                            Icons.check,
                            size: 30,
                            color: Color(0xFF5C6BC0),
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
                fontWeight: FontWeight.w700,
              ),
            ),
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
                final List<String> messages = [
                  'お疲れ様でした！',
                  '頑張りました！',
                  'この調子です！',
                  'えらい！',
                  'さすがです！'
                ];
                final Random random = new Random();
                final int randomNumber = random.nextInt(5);
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(messages[randomNumber]),
                    duration: Duration(seconds: 1),
                  ),
                );
              } else {
                controller.unfinishPlan(index, 'tomorrow');
              }
            },
          ),
        );
      },
    );
  }
}
