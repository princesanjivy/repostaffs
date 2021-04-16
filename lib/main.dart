import 'package:flutter/material.dart';
import 'package:repostaffs/LoginPage.dart';
import 'package:repostaffs/constants.dart';
import 'package:repostaffs/constants.dart';
import 'package:repostaffs/Sign_Up.dart';

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
