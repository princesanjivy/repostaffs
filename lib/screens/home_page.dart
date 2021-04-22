import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repostaffs/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:repostaffs/components/my_text.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50.0,
              child: Text('Hello' + firebaseUser.uid),
            ),
            Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                MyText(
                  'Home',
                  color: Colors.white,
                  size: 24,
                  fontWeight: 'Medium',
                ),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            Center(
              child: Container(
                width: 290,
                height: 170,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://djx5h8pabpett.cloudfront.net/wp-content/uploads/sites/4/2016/04/28071704/ToniGuy.jpg'),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                  border: Border.all(
                    color: Colors.black,
                    width: 5.0,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
            SizedBox(height: 110),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: () {}, //add navigator to the Attendance page
                    splashColor: Colors.white,
                    child: Container(
                      height: 130,
                      width: 136,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(
                          20.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.qr_code_scanner,
                              size: 25.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
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
                SizedBox(
                  width: 30.0,
                ),
                Material(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap:
                        () {}, //add navigator to the Service Status Upload Page
                    splashColor: Colors.white,
                    child: Container(
                      height: 130,
                      width: 136,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30),
                      ),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(25),
                      onTap: () {}, //Add Navigator to the Gallery Page
                      splashColor: Colors.white,
                      child: Container(
                        height: 130,
                        width: 136,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(30),
                        ),
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
                  SizedBox(
                    width: 30.0,
                  ),
                  Material(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(25),
                      onTap: () {
                        context.read<AuthenticationService>().signOut();
                      },
                      splashColor: Colors.white,
                      child: Container(
                        height: 130,
                        width: 136,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(30),
                        ),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
