import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repostaffs/components/my_appbar.dart';
import 'package:repostaffs/components/my_text.dart';
import 'package:repostaffs/constants.dart';
import 'package:repostaffs/providers/auth.dart';
import 'package:repostaffs/screens/staff_attendance.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Stream<User> data =
        Provider.of<AuthenticationProvider>(context, listen: false)
            .authStateChanges;
    data.listen((user) {
      print(user.email);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final firebaseUser = context.watch<User>();

    return Scaffold(
      appBar: MyAppBar(
        "Home",
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              width: 290,
              height: 170,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://djx5h8pabpett.cloudfront.net/wp-content/uploads/sites/4/2016/04/28071704/ToniGuy.jpg'),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(20),
                color: PRIMARY,
                border: Border.all(
                  color: PRIMARY,
                  width: 5.0,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            SizedBox(height: 100),
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
                            builder: (context) => StaffAttendance(),
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
                      onTap:
                          () {}, //add navigator to the Service Status Upload Page
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
                                  padding: const EdgeInsets.only(top: 10.0),
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
                        onTap: () {
                          context.read<AuthenticationProvider>().signOut();
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
                                  padding: const EdgeInsets.only(top: 10.0),
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
      ),
    );
  }
}
