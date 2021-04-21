import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:repostaffs/components/my_text.dart';
import 'package:repostaffs/constants.dart';
import 'package:repostaffs/screens/home_page.dart';
import 'package:repostaffs/screens/staff_attendance.dart';
import 'package:repostaffs/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:repostaffs/helpers/upload_file.dart';

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
            toolbarWidgetColor: Colors.white,
            cropGridColor: Colors.white,
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
    return Scaffold(
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
                  color: Colors.white,
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
                              color: Colors.white,
                            ),
                            height: 150,
                            width: double.infinity,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                    color: Colors.white,
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
                color: Colors.white,
                fontWeight: 'Light',
                size: 18,
              ),
              onPressed: () async {
                context
                    .read<AuthenticationService>()
                    .signUp(email: widget.email, password: widget.password)
                    .then(
                  (result) async {
                    if (result == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Failed to create account,Please enter a Valid Email',
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: MyText(
                            'Account Created Successfully',
                            color: Colors.black,
                          ),
                          backgroundColor: Colors.white,
                        ),
                      );
                      await UploadImageToFireStore(
                              file: _selectedFile, path: 'userpic')
                          .uploadAndGetUrl()
                          .then(
                        (imageUrl) async {
                          FirebaseFirestore firestore =
                              FirebaseFirestore.instance;
                          firestore.collection('users').doc(result.uid).set(
                            {
                              'email': widget.email,
                              'name': widget.name,
                              'phoneNo': widget.mobNo,
                              'imageUrl': imageUrl
                            },
                          );
                        },
                      );
                    }
                  },
                );
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
                minimumSize: MaterialStateProperty.all<Size>(Size(120, 55)),
                backgroundColor: MaterialStateProperty.all((PRIMARY)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
