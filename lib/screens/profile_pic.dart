import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:repostaffs/components/my_text.dart';
import 'package:repostaffs/constants.dart';
import 'package:repostaffs/helpers/upload_file.dart';
import 'package:repostaffs/providers/auth.dart';

class Profile extends StatefulWidget {
  final String email;
  final String name;
  final String mobNo;
  final String password;
  Profile({this.email, this.password, this.name, this.mobNo});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File _selectedFile;
  bool _inProcess = false;
  bool _loading = false;

  // AuthService _auth = new AuthService();
  UploadImageToFireStore imageToFireStore = UploadImageToFireStore();

  getImageWidget() {
    if (_selectedFile != null) {
      return FileImage(
        _selectedFile,
      );
    } else {
      return AssetImage('assets/Nousrpic.png');
    }
  }

  getImage(ImageSource source) async {
    this.setState(() {
      _inProcess = true;
    });
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
        _inProcess = false;
      });
    } else {
      this.setState(() {
        _inProcess = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserClass>(context);
    return _loading
        ? Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    backgroundColor: PRIMARY,
                    valueColor: AlwaysStoppedAnimation<Color>(WHITE),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  MyText(
                    'Creating your account and Signing in,',
                    color: WHITE,
                    fontWeight: 'Medium',
                    size: 16,
                  ),
                  MyText(
                    'Please Wait',
                    color: WHITE,
                    fontWeight: 'Medium',
                    size: 16,
                  )
                ],
              ),
            ),
          )
        : Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 45.0,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 30.0,
                      ),
                      MyText(
                        'Upload an Image for\nyour Profile',
                        color: WHITE,
                        fontWeight: 'Medium',
                        size: 24.0,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 200.0,
                  ),
                  Stack(children: [
                    CircleAvatar(
                      backgroundImage: getImageWidget(),
                      radius: 100.0,
                    ),
                    Positioned(
                      top: 150,
                      left: 150,
                      child: CircleAvatar(
                        radius: 25.0,
                        backgroundColor: PRIMARY,
                        child: IconButton(
                          splashRadius: 30,
                          onPressed: () {
                            showModalBottomSheet(
                              enableDrag: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40.0),
                                      topRight: Radius.circular(40.0),
                                    ),
                                    color: WHITE,
                                  ),
                                  height: 150,
                                  width: double.infinity,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton.icon(
                                          onPressed: () {
                                            getImage(ImageSource.camera);
                                          }, //ImageSource.camera
                                          icon: Icon(
                                            Icons.camera_alt,
                                            color: Colors.black,
                                          ),
                                          label: MyText(
                                            'Capture',
                                            color: Colors.black,
                                            fontWeight: 'Medium',
                                            size: 16,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20.0,
                                        ),
                                        TextButton.icon(
                                          onPressed: () {
                                            getImage(ImageSource.gallery);
                                          }, //ImageSource.gallery
                                          icon: Icon(
                                            Icons.photo_library,
                                            color: Colors.black,
                                          ),
                                          label: MyText(
                                            'Gallery',
                                            color: Colors.black,
                                            fontWeight: 'Medium',
                                            size: 16,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.camera_alt,
                          ),
                          color: WHITE,
                        ),
                      ),
                    )
                  ]),
                  SizedBox(
                    height: 150.0,
                  ),
                  ElevatedButton(
                    child: MyText(
                      'Done',
                      color: WHITE,
                      fontWeight: 'Light',
                      size: 18,
                    ),
                    onPressed: () async {
                      if (_selectedFile == null) {
                        Fluttertoast.showToast(
                          msg: 'Please Upload an Image',
                          backgroundColor: WHITE,
                          textColor: PRIMARY,
                        );
                      } else {
                        setState(() {
                          _loading = true;
                        });
                        await context
                            .read<AuthenticationProvider>()
                            .signUp(
                                email: widget.email, password: widget.password)
                            .then((result) async {
                          print('Hello by Pro_Pic');
                          if (result == null) {
                            Fluttertoast.showToast(
                                msg:
                                    'Failed to create account, Please enter a valid email address',
                                backgroundColor: WHITE,
                                textColor: PRIMARY);
                            Navigator.pop(context);
                          } else {
                            await UploadImageToFireStore(
                                    file: _selectedFile, path: 'userpic')
                                .uploadAndGetUrl()
                                .then(
                              (imageUrl) async {
                                FirebaseFirestore firestore =
                                    FirebaseFirestore.instance;
                                await firestore
                                    .collection('users')
                                    .doc(result.uid)
                                    .set(
                                  {
                                    'email': widget.email,
                                    'name': widget.name,
                                    'phoneNo': widget.mobNo,
                                    'imageUrl': imageUrl
                                  },
                                ).then((value) {
                                  Fluttertoast.showToast(
                                      msg: 'Account Created Successfully!',
                                      backgroundColor: WHITE,
                                      textColor: PRIMARY);

                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                });
                              },
                            );

                            setState(() {
                              _loading = false;
                            });
                          }
                        });
                      }
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(15),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        (RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            19,
                          ),
                        )),
                      ),
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(120, 55)),
                      backgroundColor: MaterialStateProperty.all((PRIMARY)),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
