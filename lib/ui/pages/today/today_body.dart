import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomorrow_plan/controller/today_controller.dart';

class TodayBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<TodayController>(context);
    final todayPlan= controller.todayPlan;
    if(todayPlan==null){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView.builder(
      itemCount: todayPlan.length,
      itemBuilder: (context, index) {
        final event = todayPlan[index];
        return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2,color: Colors.grey),
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
                child: event['isFinish']
                    ? Icon(
                        Icons.check,
                        size: 30,
                        color: const Color(0xFF5C6BC0),
                      )
                    : SizedBox(),
              ),
            ),
            title: Text(
              event['title'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () {
              if (!event['isFinish']) {
                controller.finish(index);
              } else {
                controller.unfinish(index);
              }
            },
          ),
        );
      },
    );
  }
}
