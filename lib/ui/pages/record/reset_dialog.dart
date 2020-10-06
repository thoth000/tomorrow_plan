import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomorrow_plan/controller/record_controller.dart';
import 'package:vibration/vibration.dart';

class ResetDialog extends StatefulWidget {
  @override
  _ResetDialogState createState() => _ResetDialogState();
}

class _ResetDialogState extends State<ResetDialog> {
  int tapTime = 0;
  Future<void> tap() async {
    setState(() {
      tapTime += 1;
    });
    if (tapTime == 3) {
      await Provider.of<RecordController>(context, listen: false).resetData();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> message = ['削除する', 'あと2回', 'あと1回', '削除', '保険', '保険2'];
    return AlertDialog(
      title: Text('データの削除'),
      content: Text('これによってアプリの動作が快適になる可能性があります。3回ボタンを押すとデータが削除されます。'),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('キャンセル'),
        ),
        FlatButton(
          onPressed: () async {
            await tap();
            Vibration.vibrate(duration: 50);
          },
          child: Text(
            message[tapTime],
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
