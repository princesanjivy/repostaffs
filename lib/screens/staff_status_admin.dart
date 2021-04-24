import 'package:flutter/material.dart';
import 'package:repostaffs/components/my_appbar.dart';
import 'package:repostaffs/components/my_text.dart';
import 'package:repostaffs/constants.dart';
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
      body: ListView.builder(
        // padding: EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return InkWell(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1618374509394-3606c0aaf289?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
                    ),
                    backgroundColor: PRIMARY,
                  ),

                  /// todo change into separate class
                  SizedBox(
                    width: 16,
                  ),
                  MyText(
                    "Prince",
                    size: 16,
                    fontWeight: "Light",
                    color: WHITE,
                  ),
                ],
              ),
            ),
            onTap: () {
              /// todo
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StatusReport(),
                ),
              );
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
        },
        child: Icon(
          Icons.lock_clock,
        ),
      ),
    );
  }
}
