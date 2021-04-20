import 'package:repostaffs/models/user.dart';
import 'package:repostaffs/screens/home_page.dart';
import 'package:repostaffs/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserClass>(context);
    if (user != null) {
      return HomePage();
    } else {
      return Login();
    }
  }
}
