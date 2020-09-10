import 'package:flutter/material.dart';

class TodayAppBar extends StatelessWidget implements PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text("今日の予定"),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}