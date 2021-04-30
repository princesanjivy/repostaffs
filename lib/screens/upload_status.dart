import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:repostaffs/components/my_appbar.dart';
import 'package:repostaffs/components/my_dropdown.dart';
import 'package:repostaffs/components/my_text.dart';
import 'package:repostaffs/constants.dart';

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

  int count = 1;
  String choosenValue;
  File _selectedFile;
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
        ),
      );

      setState(() {
        _inProcess = false;
      });
    });
  }

  getImage(ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);
    if (image != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            activeControlsWidgetColor: Colors.purple[800],
            toolbarWidgetColor: WHITE,
            cropGridColor: WHITE,
            toolbarColor: SECONDARY,
            toolbarTitle: "Adjust your Image",
            statusBarColor: SECONDARY,
            backgroundColor: SECONDARY,
          ));
      this.setState(() {
        _selectedFile = cropped;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
              ),
            );
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
          ? Center(child: CircularProgressIndicator())
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
                                          items.removeAt(index);
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
                    if (_selectedFile != null)
                      ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 2,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Text('None');
                          }),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          getImage(ImageSource.camera);
                        },
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
                        onPressed: () async {}, //firebase code to be added.
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
                    Center(
                      //Add Images preview list code.
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: _selectedFile == null
                            ? Container()
                            : Image.file(
                                _selectedFile,
                                fit: BoxFit.cover,
                                width: 200,
                                height: 200,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget temp(Widget d) {
    return d;
  }
}
