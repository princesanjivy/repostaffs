import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:repostaffs/components/my_appbar.dart';
import 'package:repostaffs/components/my_text.dart';
import 'package:repostaffs/constants.dart';
import 'package:repostaffs/helpers/format_date.dart';
import 'package:repostaffs/screens/status_report.dart';

class StaffStatusAdmin extends StatefulWidget {
  @override
  _StaffStatusAdminState createState() => _StaffStatusAdminState();
}

class _StaffStatusAdminState extends State<StaffStatusAdmin> {
  DateTime pickedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("Staff's Status"),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .orderBy("name")
              .snapshots(),
          builder: (context, userSnapshot) {
            if (!userSnapshot.hasData)
              return Center(child: CircularProgressIndicator());

            return ListView.builder(
              itemCount: userSnapshot.data.size,
              itemBuilder: (context, index) {
                return InkWell(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            userSnapshot.data.docs[index].get("imageUrl"),
                          ),
                          backgroundColor: PRIMARY,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        MyText(
                          userSnapshot.data.docs[index].get("name"),
                          size: 16,
                          fontWeight: "Light",
                          color: WHITE,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    /// todo
                    print(dateToString(pickedDate));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StatusReport(
                          appBarTitle:
                              userSnapshot.data.docs[index].get("name"),
                          date: dateToString(pickedDate),
                          profilePic:
                              userSnapshot.data.docs[index].get("imageUrl"),
                          uid: userSnapshot.data.docs[index].id,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }),
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
        },
        child: Icon(
          Icons.lock_clock,
        ),
      ),
    );
  }
}
