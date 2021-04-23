import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repostaffs/components/my_appbar.dart';
import 'package:repostaffs/components/my_text.dart';
import 'package:repostaffs/constants.dart';
import 'package:repostaffs/helpers/format_date.dart';

class AttendancePreview extends StatefulWidget {
  @override
  _AttendancePreviewState createState() => _AttendancePreviewState();
}

class _AttendancePreviewState extends State<AttendancePreview> {
  DateTime pickedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("Staff's Status"),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("attendance")
            .where("date", isEqualTo: dateToString(pickedDate))
            .snapshots(),
        builder: (context, attendanceSnapshot) {
          if (!attendanceSnapshot.hasData)
            return Center(child: CircularProgressIndicator());
          List data;
          if (attendanceSnapshot.data.size != 0) {
            data = attendanceSnapshot.data.docs[0].get("staffs");
          }

          return attendanceSnapshot.data.size == 0
              ? Center(
                  child: MyText(
                    "No data found!",
                    color: Colors.white,
                    fontWeight: "Light",
                  ),
                )
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("users")
                            .doc(data[index])
                            .snapshots(),
                        builder: (context, userSnapshot) {
                          if (!userSnapshot.hasData)
                            return Center(child: CircularProgressIndicator());

                          return !userSnapshot.data.exists
                              ? Container()
                              : Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          userSnapshot.data.get("imageUrl"),
                                        ),
                                        backgroundColor: PRIMARY,
                                      ),

                                      /// todo change into separate class
                                      SizedBox(
                                        width: 16,
                                      ),
                                      MyText(
                                        userSnapshot.data.get("name"),
                                        size: 16,
                                        fontWeight: "Light",
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                );
                        });
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDatePicker(
            context: context,
            initialDate: pickedDate,
            firstDate: DateTime(1900),
            lastDate: DateTime(2030),
            confirmText: "SET",
            builder: (BuildContext context, Widget child) {
              return Theme(
                data: ThemeData.dark().copyWith(
                  colorScheme: ColorScheme.dark(
                    primary: PRIMARY,
                    onPrimary: Colors.white,
                    surface: PRIMARY,
                    // onSurface: PRIMARY,
                  ),
                  // dialogBackgroundColor: Colors.white,
                ),
                child: child,
              );
            },
          ).then((value) {
            if (value != null)
              setState(() {
                pickedDate = value;
              });
          });

          // if (pickedDate != null)
          //   setState(() {
          //     pickedDate = date;
          //   });
        },
        child: Icon(
          Icons.lock_clock,
        ),
      ),
    );
  }
}
