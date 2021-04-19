import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:repostaffs/components/my_appbar.dart';
import 'package:repostaffs/components/my_text.dart';
import 'package:repostaffs/constants.dart';

class StaffAttendance extends StatefulWidget {
  @override
  _StaffAttendanceState createState() => _StaffAttendanceState();
}

class _StaffAttendanceState extends State<StaffAttendance> {
  int status = -1;
  bool callMethod = false;
  QRViewController controller;

  final GlobalKey qrKey = GlobalKey();
  String code = DateFormat.yMMMMEEEEd().format(DateTime.now()).toString();

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  attendance() async {
    await FirebaseFirestore.instance
        .collection("attendance")
        .where("date", isEqualTo: code)
        .get()
        .then((value) async {
      if (value.size == 0) {
        await FirebaseFirestore.instance.collection("attendance").add({
          "date": code,
          "staffs": [
            "Prince",
          ],
        });

        setState(() {
          status = 0;
        });

        return;
      } else {
        List temp = value.docs[0].get("staffs");
        if (temp.contains("Sanjivy")) {
          setState(() {
            status = 1;
          });

          return;
        } else {
          temp.add("Sanjivy");
          await FirebaseFirestore.instance
              .collection("attendance")
              .doc(value.docs[0].id)
              .set({
            "staffs": temp,
          }, SetOptions(merge: true));

          setState(() {
            status = 0;
          });

          return;
        }
      }
    });

    setState(() {
      callMethod = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (callMethod) {
      attendance();
    }
    return Scaffold(
      appBar: MyAppBar(
        "Attendance",
      ),
      body: Center(
        child: status == 0
            ? MyText(
                "Welcome",
                color: Colors.white,
              )
            : status == 1
                ? MyText(
                    "You already scanned!",
                    color: Colors.white,
                  )
                : _buildQrView(context),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    return QRView(
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: SECONDARY,
        borderRadius: 15,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: 250,
      ),
      key: qrKey,
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      if (code == scanData.code) {
        setState(() {
          controller.stopCamera();
          callMethod = true;
        });
      }
    });
  }
}