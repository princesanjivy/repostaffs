import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:repostaffs/components/my_appbar.dart';
import 'package:repostaffs/components/my_text.dart';
import 'package:repostaffs/constants.dart';
import 'package:repostaffs/providers/auth.dart';
import 'package:repostaffs/screens/add_edit_service.dart';
import 'package:repostaffs/screens/attendance_admin.dart';
import 'package:repostaffs/screens/staff_status_admin.dart';

class HomePageAdmin extends StatefulWidget {
  @override
  _HomePageAdminState createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  bool _loggingOut = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Scaffold(
        appBar: MyAppBar(
          "Home",
        ),
        body: _loggingOut
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      backgroundColor: PRIMARY,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    MyText(
                      'Logging out , Please Wait',
                      color: Colors.white,
                      fontWeight: 'Medium',
                      size: 16,
                    )
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: PRIMARY,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AttendancePreview(),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(15),
                            splashColor: Colors.white,
                            radius: 300,
                            child: Container(
                              height: 140,
                              width: 140,
                              child: Padding(
                                padding: EdgeInsets.all(
                                  20.0,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.person_add_alt_1_rounded,
                                      size: 25.0,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: MyText(
                                        'Attendance',
                                        color: Colors.white,
                                        fontWeight: 'Medium',
                                        size: 15,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: PRIMARY,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StaffStatusAdmin(),
                                ),
                              );
                            },
                            splashColor: Colors.white,
                            radius: 300,
                            child: Container(
                              height: 140,
                              width: 140,
                              child: Padding(
                                padding: EdgeInsets.all(
                                  20.0,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      size: 30.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              MyText(
                                                'Service',
                                                color: Colors.white,
                                                fontWeight: 'Medium',
                                                size: 15,
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              MyText(
                                                'Status',
                                                color: Colors.white,
                                                fontWeight: 'Medium',
                                                size: 15,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: PRIMARY,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {}, //Add Navigator to the Gallery Page
                              splashColor: Colors.white,
                              radius: 300,
                              child: Container(
                                height: 140,
                                width: 140,
                                child: Padding(
                                  padding: EdgeInsets.all(
                                    20.0,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.photo_library_rounded,
                                        color: Colors.white,
                                        size: 25.0,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: MyText(
                                          'Gallery',
                                          color: Colors.white,
                                          fontWeight: 'Medium',
                                          size: 15,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: PRIMARY,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () async {
                                setState(() {
                                  _loggingOut = true;
                                });
                                await Future.delayed(
                                    Duration(seconds: 2), null);

                                Fluttertoast.showToast(
                                  msg: 'Signed out Successfully',
                                  backgroundColor: Colors.white,
                                  textColor: PRIMARY,
                                );
                                context
                                    .read<AuthenticationProvider>()
                                    .signOut();
                              },
                              splashColor: Colors.white,
                              radius: 300,
                              child: Container(
                                height: 140,
                                width: 140,
                                child: Padding(
                                  padding: EdgeInsets.all(
                                    20.0,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.logout,
                                        color: Colors.white,
                                        size: 25.0,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: MyText(
                                          'Logout',
                                          color: Colors.white,
                                          fontWeight: 'Medium',
                                          size: 15,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
        floatingActionButton: !_loggingOut
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEditService(),
                    ),
                  );
                },
                child: Icon(
                  Icons.add,
                ),
              )
            : null,
      ),
    );
  }
}
