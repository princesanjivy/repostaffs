import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repostaffs/screens/home_page.dart';
import 'package:repostaffs/screens/home_page_admin.dart';
import 'package:repostaffs/screens/login.dart';
import 'package:repostaffs/screens/upload_status.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      if (firebaseUser.email == "getme.jj16@gmail.com")
        return HomePageAdmin();
      else
        return HomePage();
    } else
      return Login();
  }
}
