import 'package:flutter/material.dart';
import 'package:repostaffs/constants.dart';
import 'package:repostaffs/screens/sign_up.dart';
import 'package:repostaffs/screens/staff_status_admin.dart';
import 'package:repostaffs/screens/login.dart';
import 'package:repostaffs/screens/profile_pic.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'LoginPage': (context) => Login(),
        'Register': (context) => SignUp(),
        'ProfilePic': (context) => Profile(),
      },
      theme: ThemeData(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        buttonColor: Colors.white,

        // textTheme: GoogleFonts.poppinsTextTheme().apply(
        //   bodyColor: Colors.white,
        // ),

        // textTheme: GoogleFonts.poppinsTextTheme().apply(
        //   bodyColor: Colors.white,
        // ),
        primaryColor: PRIMARY,
        canvasColor: SECONDARY,
        accentColor: PRIMARY,
      ),
      home: Login(),
    );
  }
}
