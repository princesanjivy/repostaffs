import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:repostaffs/components/fullscreen_view.dart';
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
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            );
          List data, checkIn;
          if (attendanceSnapshot.data.size != 0) {
            data = attendanceSnapshot.data.docs[0].get("staffs");
            checkIn = attendanceSnapshot.data.docs[0].get("checkIn");
          }

          return attendanceSnapshot.data.size == 0
              ? Center(
                  child: MyText(
                    "Nobody still here",
                    color: WHITE,
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
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.black),
                              ),
                            );

                          return !userSnapshot.data.exists
                              ? Container()
                              : Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      FullScreenView(
                                                    child: Image.network(
                                                      userSnapshot.data
                                                          .get("imageUrl"),
                                                    ),
                                                    title: userSnapshot.data
                                                        .get("name"),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                userSnapshot.data
                                                    .get("imageUrl"),
                                              ),
                                              backgroundColor: PRIMARY,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          MyText(
                                            userSnapshot.data.get("name"),
                                            size: 16,
                                            fontWeight: "Light",
                                            color: WHITE,
                                          ),
                                        ],
                                      ),
                                      MyText(
                                        DateFormat.jms()
                                            .format(
                                              checkIn[index][data[index]]
                                                  .toDate(),
                                            )
                                            .toString(),
                                        size: 16,
                                        fontWeight: "Light",
                                        color: WHITE,
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
                    onPrimary: WHITE,
                    surface: PRIMARY,
                    // onSurface: PRIMARY,
                  ),
                  // dialogBackgroundColor: WHITE,
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
