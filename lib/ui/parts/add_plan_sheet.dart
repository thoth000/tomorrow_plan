import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomorrow_plan/controller/bottom_bar_controller.dart';
import 'package:tomorrow_plan/controller/record_controller.dart';

class AddPlanSheet extends StatefulWidget {
  @override
  _AddPlanSheetState createState() => _AddPlanSheetState();
}

class _AddPlanSheetState extends State<AddPlanSheet> {
  final textEditingController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int pageIndex = Provider.of<BottomBarController>(context).index;
    final controller = Provider.of<RecordController>(context);
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            height: 8,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(500),
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              autofocus: true,
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: '予定の名前',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
              ),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.all(15),
            height: 50,
            width: double.infinity,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: const Color(0xFF5C6BC0),
              child: Center(
                child: Text(
                  '追加する',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              onPressed: () {
                final String title = textEditingController.text;
                Map event = {
                  'title': title,
                  'isFinish': false,
                };
                if (pageIndex == 0) {
                  event['planDate'] = controller.today;
                  Provider.of<RecordController>(context, listen: false)
                      .addPlan(event, 'today');
                } else if (pageIndex == 1) {
                  event['planDate'] = controller.today.add(Duration(days: 1));
                  Provider.of<RecordController>(context, listen: false)
                      .addPlan(event, 'tomorrow');
                } else {
                  event['planDate'] = controller.selectedDate;
                  Provider.of<RecordController>(context, listen: false)
                      .addPlan(event, 'normal');
                }
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
