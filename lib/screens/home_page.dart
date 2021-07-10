import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:repostaffs/components/fullscreen_view.dart';
import 'package:repostaffs/components/my_appbar.dart';
import 'package:repostaffs/components/my_text.dart';
import 'package:repostaffs/constants.dart';
import 'package:repostaffs/providers/auth.dart';
import 'package:repostaffs/screens/gallery.dart';
import 'package:repostaffs/screens/staff_attendance.dart';
import 'package:repostaffs/screens/upload_status.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loggingOut = false;

  @override
  Widget build(BuildContext context) {
    // final firebaseUser = context.watch<User>();
    List imageList = [];

    return WillPopScope(
      onWillPop: () {
        print("NO POP");
        return Future.value(false);
      },
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("gallery").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());

            int temp = 0;

            if (snapshot.data.size >= 10)
              temp = 5;
            else
              temp = snapshot.data.size;

            for (int i = 0; i < temp; i++) {
              imageList.add({
                'imageLink': snapshot.data.docs[i].get("url"),
                'customerName':
                    snapshot.data.docs[i].get('customerName').toString() != ''
                        ? snapshot.data.docs[i].get('customerName').toString()
                        : 'Customer Image'
              });
            }

            return Scaffold(
              appBar: MyAppBar(
                "Home",
              ),
              body: _loggingOut
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 10.0,
                          ),
                          MyText(
                            'Logging out , Please Wait',
                            color: WHITE,
                            fontWeight: 'Medium',
                            size: 16,
                          )
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          imageList.length == 0
                              ? Center(
                                  child: Text("No photos available"),
                                )
                              : CarouselSlider.builder(
                                  itemCount: imageList.length,
                                  itemBuilder: (context, index, image) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                FullScreenView(
                                              child: Image.network(
                                                imageList[index]['imageLink'],
                                                fit: BoxFit.cover,
                                              ),
                                              title: imageList[index]
                                                  ['customerName'],

                                              // title: gallerySnapshot.data.docs[index]
                                              // .get("customerName")
                                              // .toString(),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 300,
                                        height: 200,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: WHITE,
                                            width: 3,
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                imageList[index]['imageLink']),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  options: CarouselOptions(
                                    autoPlay: true,
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: true,
                                    enableInfiniteScroll: true,
                                  ),
                                ),
                          SizedBox(height: 80),
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
                                          builder: (context) =>
                                              StaffAttendance(),
                                        ),
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(15),
                                    splashColor: WHITE,
                                    radius: 300,
                                    child: Container(
                                      height: 140,
                                      width: 140,
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                          20.0,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.person_add_alt_1_rounded,
                                              size: 25.0,
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 10.0),
                                              child: MyText(
                                                'Attendance',
                                                color: WHITE,
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
                                            builder: (context) =>
                                                UploadStatus()),
                                      );
                                    }, //add navigator to the Service Status Upload Page
                                    splashColor: WHITE,
                                    radius: 300,
                                    child: Container(
                                      height: 140,
                                      width: 140,
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                          20.0,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.check_circle,
                                              size: 30.0,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      MyText(
                                                        'Service',
                                                        color: WHITE,
                                                        fontWeight: 'Medium',
                                                        size: 15,
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      MyText(
                                                        'Status',
                                                        color: WHITE,
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
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Gallery(),
                                          ),
                                        );
                                      }, //Add Navigator to the Gallery Page
                                      splashColor: WHITE,
                                      radius: 300,
                                      child: Container(
                                        height: 140,
                                        width: 140,
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                            20.0,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.photo_library_rounded,
                                                color: WHITE,
                                                size: 25.0,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0),
                                                child: MyText(
                                                  'Gallery',
                                                  color: WHITE,
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
                                          backgroundColor: WHITE,
                                          textColor: PRIMARY,
                                        );
                                        context
                                            .read<AuthenticationProvider>()
                                            .signOut();
                                      },
                                      splashColor: WHITE,
                                      radius: 300,
                                      child: Container(
                                        height: 140,
                                        width: 140,
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                            20.0,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.logout,
                                                color: WHITE,
                                                size: 25.0,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0),
                                                child: MyText(
                                                  'Logout',
                                                  color: WHITE,
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
                          SizedBox(
                            height: 40.0,
                          ),
                          MyText(
                            'Designed & Developed by',
                            color: WHITE,
                            fontWeight: 'Medium',
                            size: 10,
                          ),
                          SizedBox(
                            height: 2.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  launch('https://linktr.ee/princesanjivy');
                                },
                                child: MyText(
                                  'Princesanjivy',
                                  color: WHITE,
                                  size: 12,
                                  fontWeight: 'SemiBold',
                                ),
                              ),
                              MyText(
                                ' and ',
                                color: WHITE,
                                size: 12,
                                fontWeight: 'SemiBold',
                              ),
                              InkWell(
                                onTap: () {
                                  launch('https://vigneshhendrix.github.io/#/');
                                },
                                child: MyText(
                                  'Vignesh Hendrix',
                                  color: WHITE,
                                  size: 12,
                                  fontWeight: 'SemiBold',
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
            );
          }),
    );
  }
}
