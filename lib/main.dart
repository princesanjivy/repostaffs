import 'package:flutter/material.dart';
import 'package:repostaffs/LoginPage.dart';
import 'package:repostaffs/constants.dart';
import 'package:repostaffs/constants.dart';
import 'package:repostaffs/screens/staff_status_admin.dart';

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
      theme: ThemeData(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        buttonColor: Colors.white,
        scaffoldBackgroundColor: SECONDARY,
      ),
      home: Login(),
      // textTheme: GoogleFonts.poppinsTextTheme().apply(
      //   bodyColor: Colors.white,
      // ),
    );
  }
}
