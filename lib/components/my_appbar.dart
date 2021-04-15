import 'package:flutter/material.dart';
import 'package:repostaffs/components/my_text.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  MyAppBar(
    this.title, {
    Key key,
  })  : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: MyText(
        title,
        fontWeight: "Medium",
        size: 26,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
