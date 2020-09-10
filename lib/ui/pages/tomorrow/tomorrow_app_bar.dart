import 'package:flutter/material.dart';

class TomorrowAppBar extends StatelessWidget implements PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text("明日の予定"),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}