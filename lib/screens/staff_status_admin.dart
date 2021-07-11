import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:repostaffs/components/fullscreen_view.dart';
import 'package:repostaffs/components/my_appbar.dart';
import 'package:repostaffs/components/my_text.dart';
import 'package:repostaffs/constants.dart';
import 'package:repostaffs/helpers/format_date.dart';
import 'package:repostaffs/helpers/generate_excel.dart';
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
              return Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ));

            return ListView.builder(
              itemCount: userSnapshot.data.size,
              itemBuilder: (context, index) {
                return InkWell(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullScreenView(
                                  child: Image.network(
                                    userSnapshot.data.docs[index]
                                        .get("imageUrl"),
                                    fit: BoxFit.cover,
                                  ),
                                  title:
                                      userSnapshot.data.docs[index].get("name"),
                                ),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              userSnapshot.data.docs[index].get("imageUrl"),
                            ),
                            backgroundColor: PRIMARY,
                          ),
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
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "download",
            onPressed: () async {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => SimpleDialog(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            "Generating excel...",
                            size: 16,
                          ),
                          Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
              await FirebaseFirestore.instance
                  .collection("users")
                  .get()
                  .then((value) async {
                Map temp = {};
                for (int i = 0; i < value.size; i++) {
                  temp.addAll({value.docs[i].id: value.docs[i].get("name")});
                }
                await FirebaseFirestore.instance
                    .collection("status")
                    // .where("date", isEqualTo: dateToString(pickedDate))
                    .get()
                    .then((value) {
                  GenerateExcel(pickedDate).save(value.docs, temp, context);
                });
              });
            },
            child: Icon(
              Icons.download_rounded,
            ),
          ),
          SizedBox(
            width: 16,
          ),
          FloatingActionButton(
            heroTag: "date",
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
        ],
      ),
    );
  }
}
