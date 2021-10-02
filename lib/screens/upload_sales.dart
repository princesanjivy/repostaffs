import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:repostaffs/components/my_appbar.dart';
import 'package:repostaffs/components/my_text.dart';
import 'package:repostaffs/constants.dart';

class UploadSales extends StatefulWidget {
  @override
  _UploadSalesState createState() => _UploadSalesState();
}

class _UploadSalesState extends State<UploadSales> {
  Map<String, List> services = {};

  Map toUploadServices = {};
  List listOfServices = [
    "Men",
    "Women",
    "Color & Treatment",
    "Facials",
    "Body",
  ];

  TextEditingController pos1 = new TextEditingController();
  TextEditingController cash1 = new TextEditingController();
  TextEditingController pos2 = new TextEditingController();
  TextEditingController cash2 = new TextEditingController();
  TextEditingController expenses = new TextEditingController();

  List fileImages = [];
  int count = 1;
  String choosenValue;
  File _selectedFile;
  int photoLimit = 1;
  int stateIndex = 0;

  bool _inProcess = false;

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    return Scaffold(
      appBar: MyAppBar("Upload Sales"),
      body: _inProcess
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
                SizedBox(
                  height: 10.0,
                ),
                MyText(
                  'Updating sales status',
                  color: WHITE,
                  fontWeight: 'Medium',
                  size: 14,
                ),
                MyText(
                  'Please Wait',
                  color: WHITE,
                  fontWeight: 'Medium',
                  size: 14,
                ),
              ],
            ))
          : ListView(
              padding: EdgeInsets.all(16),
              children: [
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(13),
                      labelText: "Pos 1",
                      labelStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        color: WHITE,
                        letterSpacing: 1.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: PRIMARY,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: WHITE,
                        ),
                      ),
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.white38,
                        letterSpacing: 1.0,
                      ),
                    ),
                    style: GoogleFonts.poppins(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                      color: WHITE,
                      letterSpacing: 1.0,
                    ),
                    controller: pos1,
                    autocorrect: true,
                    cursorColor: WHITE,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(13),
                      labelText: "Cash 1",
                      labelStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        color: WHITE,
                        letterSpacing: 1.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: PRIMARY,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: WHITE,
                        ),
                      ),
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.white38,
                        letterSpacing: 1.0,
                      ),
                    ),
                    style: GoogleFonts.poppins(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                      color: WHITE,
                      letterSpacing: 1.0,
                    ),
                    controller: cash1,
                    autocorrect: true,
                    cursorColor: WHITE,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(13),
                      labelText: "Pos 2",
                      labelStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        color: WHITE,
                        letterSpacing: 1.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: PRIMARY,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: WHITE,
                        ),
                      ),
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.white38,
                        letterSpacing: 1.0,
                      ),
                    ),
                    style: GoogleFonts.poppins(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                      color: WHITE,
                      letterSpacing: 1.0,
                    ),
                    controller: pos2,
                    autocorrect: true,
                    cursorColor: WHITE,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(13),
                      labelText: "Cash 2",
                      labelStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        color: WHITE,
                        letterSpacing: 1.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: PRIMARY,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: WHITE,
                        ),
                      ),
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.white38,
                        letterSpacing: 1.0,
                      ),
                    ),
                    style: GoogleFonts.poppins(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                      color: WHITE,
                      letterSpacing: 1.0,
                    ),
                    controller: cash2,
                    autocorrect: true,
                    cursorColor: WHITE,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(13),
                      labelText: "Expenses",
                      labelStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        color: WHITE,
                        letterSpacing: 1.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: PRIMARY,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: WHITE,
                        ),
                      ),
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.white38,
                        letterSpacing: 1.0,
                      ),
                    ),
                    style: GoogleFonts.poppins(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                      color: WHITE,
                      letterSpacing: 1.0,
                    ),
                    controller: expenses,
                    autocorrect: true,
                    cursorColor: WHITE,
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!(pos1.text.isEmpty &&
                          cash1.text.isEmpty &&
                          pos2.text.isEmpty &&
                          cash2.text.isEmpty &&
                          expenses.text.isEmpty)) {
                        setState(() {
                          _inProcess = true;
                        });

                        await FirebaseFirestore.instance
                            .collection("sales")
                            .add({
                          "pos1": pos1.text.trim(),
                          "cash1": cash1.text.trim(),
                          "pos2": pos2.text.trim(),
                          "cash2": cash2.text.trim(),
                          "expenses": expenses.text.trim(),
                          "date": DateTime.now().millisecondsSinceEpoch,
                        });

                        setState(() {
                          _inProcess = false;
                        });
                        Navigator.pop(context);
                      }
                    },
                    style: ButtonStyle(
                      // elevation: MaterialStateProperty.all<double>(15),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19),
                        ),
                      ),
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(120, 55)),
                      backgroundColor: MaterialStateProperty.all((PRIMARY)),
                    ),
                    child: MyText(
                      "Save",
                      color: WHITE,
                      fontWeight: 'Light',
                      size: 18,
                    ),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
              ],
            ),
    );
  }
}
