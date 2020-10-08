import 'package:flutter/material.dart';
import 'package:tomorrow_plan/ui/parts/add_plan_sheet.dart';

class MyFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xFF5C6BC0),
      child: Icon(
        Icons.add,
      ),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => AddPlanSheet(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
        );
      },
    );
  }
}
