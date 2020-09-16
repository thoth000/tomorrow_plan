import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomorrow_plan/controller/today_controller.dart';
import 'package:tomorrow_plan/ui/parts/action_sheet.dart';

class TodayBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<TodayController>(context);
    final todayPlan = controller.todayPlan;
    if (todayPlan == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView.builder(
      itemCount: todayPlan.length,
      itemBuilder: (context, index) {
        final event = todayPlan[index];
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
                            color: Color(0xFF5C6BC0),
                            size: 30,
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
                controller.finishPlan(index);
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
                controller.unfinishPlan(index);
              }
            },
          ),
        );
      },
    );
  }
}
