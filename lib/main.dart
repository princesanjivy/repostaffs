import 'package:flutter/material.dart';
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
        // textTheme: GoogleFonts.poppinsTextTheme().apply(
        //   bodyColor: Colors.white,
        // ),
        primaryColor: PRIMARY,
        canvasColor: SECONDARY,
      ),
      home: StaffStatusAdmin(),
    );
  }
}
