import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomorrow_plan/controller/tomorrow_controller.dart';
import 'package:tomorrow_plan/ui/parts/remove_plan_dialog.dart';

class TomorrowBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<TomorrowController>(context);
    final tomorrowPlan = controller.tomorrowPlan;
    if (tomorrowPlan == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
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
                child: const Icon(
                  Icons.remove,
                  color: const Color(0xFF5C6BC0),
                  size: 35,
                ),
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
              showDialog(
                context: context,
                child: RemovePlanDialog(
                  planIndex: index,
                ),
              );
              //controller.removePlan(index);
            },
          ),
        );
      },
    );
  }
}
