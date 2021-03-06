import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomorrow_plan/controller/record_controller.dart';

class TodayAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    final RecordController recordController =
        Provider.of<RecordController>(context);
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        "今日の予定",
        style: TextStyle(
          color: const Color(0xFF5C6BC0),
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            (recordController.isEditing) ? Icons.clear : Icons.edit,
          ),
          color: Colors.red,
          onPressed: () => recordController.switchMode(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
