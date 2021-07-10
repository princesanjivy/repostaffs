import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:repostaffs/components/my_appbar.dart';
import 'package:repostaffs/components/my_dropdown.dart';
import 'package:repostaffs/components/my_text.dart';
import 'package:repostaffs/constants.dart';
import 'package:repostaffs/helpers/format_date.dart';
import 'package:repostaffs/helpers/upload_file.dart';
import 'package:repostaffs/screens/home_page.dart';

class UploadStatus extends StatefulWidget {
  @override
  _UploadStatusState createState() => _UploadStatusState();
}

class _UploadStatusState extends State<UploadStatus> {
  List services = [
    {'name': 'Select Service'}
  ];

  TextEditingController _customerName = new TextEditingController();
  TextEditingController _mobNo = new TextEditingController();

  List fileImages = [];
  int count = 1;
  String choosenValue;
  File _selectedFile;
  int photoLimit = 1;
  int stateIndex = 0;
  bool uploading = false;

  bool _inProcess = false;

  List items = [];

  @override
  void initState() {
    super.initState();

    getServices();
  }

  getServices() async {
    setState(() {
      _inProcess = true;
    });
    await FirebaseFirestore.instance.collection("services").get().then((value) {
      for (int i = 0; i < value.size; i++) {
        var serviceDetails = {
          'name': value.docs[i].get("name").toString(),
          'price': value.docs[i].get("price").toString()
        };
        services.add(serviceDetails);
      }

      // items.add(Text("Hello"));
      items.add(
        MyDropDown(
          services: services,
          stateIndexx: stateIndex,
        ),
      );
      stateIndex++;

      setState(() {
        _inProcess = false;
      });
    });
  }

  Future<bool> getImage(ImageSource source) async {
    bool isDone;
    final _picker = ImagePicker();
    await _picker
        .getImage(source: source, imageQuality: 65)
        .then((image) async {
      if (image != null) {
        this.setState(() {
          _selectedFile = File(image.path);
        });
        isDone = true;
      } else {
        isDone = false;
      }
    });
    return isDone;
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // if (count <= 4) count++;
            // items.add(
            //   MyDropDown(
            //     services: services,
            //   ),
            // );
            // items.add(Text(
            //     "Heyyy" + DateTime.now().microsecondsSinceEpoch.toString()));
            items.add(
              MyDropDown(
                services: services,
                stateIndexx: stateIndex,
              ),
            );
            stateIndex++;
          });
        },
        child: Icon(
          Icons.add,
          color: WHITE,
        ),
        backgroundColor: PRIMARY,
        splashColor: WHITE,
      ),
      appBar: MyAppBar('Service Status'),
      body: _inProcess
          ? Center(
              child: uploading
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10.0,
                        ),
                        MyText(
                          'Updating Your Customer\'s Service Status',
                          color: WHITE,
                          fontWeight: 'Medium',
                          size: 14,
                        ),
                        MyText(
                          'Please Wait',
                          color: WHITE,
                          fontWeight: 'Medium',
                          size: 14,
                        )
                      ],
                    )
                  : CircularProgressIndicator())
          : SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 225,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(13),
                            prefixIcon: Icon(
                              Icons.person,
                              color: WHITE,
                            ),
                            labelText: 'Customer Name',
                            labelStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.w300,
                              color: WHITE,
                              letterSpacing: 1.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: PRIMARY,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: WHITE,
                              ),
                            ),
                            hintText: 'Customer Name',
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w300,
                              color: Colors.white38,
                              letterSpacing: 1.0,
                            ),
                          ),
                          style: GoogleFonts.poppins(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w300,
                            color: WHITE,
                            letterSpacing: 1.0,
                          ),
                          controller: _customerName,
                          autocorrect: true,
                          cursorColor: WHITE,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35.0,
                    ),
                    Center(
                      child: Container(
                        width: 225,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(13),
                            prefixIcon: Icon(
                              Icons.call_rounded,
                              color: WHITE,
                            ),
                            labelText: 'Customer Ph.No',
                            labelStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.w300,
                              color: WHITE,
                              letterSpacing: 1.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: PRIMARY,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: WHITE,
                              ),
                            ),
                            hintText: 'Customer Ph.No',
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w300,
                              color: Colors.white38,
                              letterSpacing: 1.0,
                            ),
                          ),
                          style: GoogleFonts.poppins(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w300,
                            color: WHITE,
                            letterSpacing: 1.0,
                          ),
                          controller: _mobNo,
                          autocorrect: true,
                          cursorColor: WHITE,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35.0,
                    ),
                    ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            if (index != 0)
                              SizedBox(
                                height: 30.0,
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                items[index],
                                Opacity(
                                  opacity: index == 0 ? 0 : 1,
                                  child: IconButton(
                                      icon: Icon(Icons.close),
                                      onPressed: () {
                                        setState(() {
                                          if (index != 0) items.removeAt(index);
                                          if ((selectedServices.length - 1) >=
                                              index)
                                            selectedServices.removeAt(index);
                                        });
                                      }),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    if (fileImages.isNotEmpty)
                      SizedBox(
                        height: 125,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ListView.builder(
                              physics: ScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: fileImages.length,
                              itemBuilder: (context, index) => Center(
                                child: Row(
                                  children: [
                                    Stack(children: [
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        color: SECONDARY,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: WHITE, width: 1),
                                              image: DecorationImage(
                                                image: FileImage(
                                                    fileImages[index]),
                                                fit: BoxFit.fill,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          width: 150,
                                          height: 200,
                                        ),
                                      ),
                                      Positioned(
                                        left: 135,
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          color: WHITE,
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            radius: 50,
                                            splashColor: SECONDARY,
                                            onTap: () {
                                              setState(() {
                                                fileImages.removeAt(index);
                                                photoLimit--;
                                                print(fileImages);
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.close,
                                                  size: 10,
                                                  color: PRIMARY,
                                                ),
                                              ),
                                              height: 20,
                                              width: 20,
                                            ),
                                          ),
                                        ),
                                      )
                                    ]),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(
                      height: 35,
                    ),
                    if (photoLimit <= 2)
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            bool val = await getImage(ImageSource.camera);
                            if (val) {
                              setState(() {
                                photoLimit++;
                                fileImages.add(_selectedFile);
                              });
                              print(fileImages);
                            }
                          },
                          style: ButtonStyle(
                            // elevation: MaterialStateProperty.all<double>(15),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(19),
                              ),
                            ),
                            minimumSize:
                                MaterialStateProperty.all<Size>(Size(120, 55)),
                            backgroundColor:
                                MaterialStateProperty.all((PRIMARY)),
                          ),
                          child: MyText(
                            'Add Photos',
                            color: WHITE,
                            fontWeight: 'Light',
                            size: 18,
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (selectedServices.isNotEmpty) {
                            List<String> customerNetImages = [];

                            setState(() {
                              _inProcess = true;
                              uploading = true;
                            });

                            for (int i = 0; i < fileImages.length; i++) {
                              await UploadImageToFireStore(
                                      file: fileImages[i], path: 'gallery')
                                  .uploadAndGetUrl()
                                  .then((url) async {
                                await FirebaseFirestore.instance
                                    .collection("gallery")
                                    .add({
                                  "url": url,
                                  "customerName": _customerName.text,
                                }).then((value) {
                                  customerNetImages.add(value.id);
                                });
                              });
                            }

                            await FirebaseFirestore.instance
                                .collection('status')
                                .add({
                              'uid': firebaseUser.uid,
                              'customerName': _customerName.text,
                              'customerPhoneNo': _mobNo.text,
                              'services': selectedServices,
                              'customerPhotos': customerNetImages,
                              'date': dateToString(DateTime.now()),
                            }).then((value) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
                              Fluttertoast.showToast(
                                msg:
                                    'Your Status has been successfully Updated',
                                textColor: PRIMARY,
                                backgroundColor: WHITE,
                              );
                            });
                          } else {
                            Fluttertoast.showToast(
                              msg: 'Enter all the details',
                              textColor: PRIMARY,
                              backgroundColor: WHITE,
                            );
                          }
                        },

                        /// firebase code to be added.
                        style: ButtonStyle(
                          // elevation: MaterialStateProperty.all<double>(15),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(19),
                            ),
                          ),
                          minimumSize:
                              MaterialStateProperty.all<Size>(Size(120, 55)),
                          backgroundColor: MaterialStateProperty.all((PRIMARY)),
                        ),
                        child: MyText(
                          'Update Status',
                          color: WHITE,
                          fontWeight: 'Light',
                          size: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class Imagepicker {}
