import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomorrow_plan/controller/record_controller.dart';
import 'package:tomorrow_plan/ui/pages/record/reset_dialog.dart';

class RecordAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    final RecordController controller = Provider.of<RecordController>(context);
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        "予定カレンダー",
        style: TextStyle(
          color: const Color(0xFF5C6BC0),
          fontWeight: FontWeight.w700,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.delete),
        color: Colors.red,
        onPressed: () {
          showDialog(context: context,builder: (context) => ResetDialog(),);
        },
      ),
      actions: [
        IconButton(
          icon: Icon(
            (controller.isEditing) ? Icons.clear : Icons.edit,
          ),
          color: Colors.red,
          onPressed: () => controller.switchMode(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
