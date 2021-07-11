import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repostaffs/components/fullscreen_view.dart';
import 'package:repostaffs/components/my_appbar.dart';
import 'package:repostaffs/components/my_text.dart';

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    return Scaffold(
      appBar: MyAppBar("Gallery"),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("gallery")
              .orderBy("customerName")
              .snapshots(),
          builder: (context, gallerySnapshot) {
            if (!gallerySnapshot.hasData)
              return Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ));

            return gallerySnapshot.data.size == 0
                ? Center(
                    child: MyText(
                      "No photos added",
                      color: Colors.white,
                    ),
                  )
                : GridView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: gallerySnapshot.data.size,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullScreenView(
                                child: CachedNetworkImage(
                                  imageUrl: gallerySnapshot.data.docs[index]
                                      .get("url"),
                                  // fit: BoxFit.cover,
                                  placeholder: (context, value) => Center(
                                      child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.black),
                                  )),
                                ),
                                title: gallerySnapshot.data.docs[index]
                                    .get("customerName")
                                    .toString(),
                              ),
                            ),
                          );
                        },
                        onDoubleTap: () {
                          if (firebaseUser.email == "getme.jj16@gmail.com")
                            showDialog(
                              context: context,
                              builder: (context) => SimpleDialog(
                                children: [
                                  Center(
                                    child: MyText(
                                      "Do you really want to delete this?",
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          Navigator.pop(context);

                                          var deleteImageUrl = gallerySnapshot
                                              .data.docs[index]
                                              .get('url');

                                          // print(deleteImageUrl);
                                          await FirebaseStorage.instance
                                              .refFromURL(deleteImageUrl)
                                              .delete();

                                          await FirebaseFirestore.instance
                                              .collection("gallery")
                                              .doc(gallerySnapshot
                                                  .data.docs[index].id)
                                              .delete();
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            Colors.black,
                                          ),
                                        ),
                                        child: MyText("YES"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: MyText(
                                          "NO",
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: GridTile(
                            child: CachedNetworkImage(
                              imageUrl:
                                  gallerySnapshot.data.docs[index].get("url"),
                              fit: BoxFit.cover,
                              placeholder: (context, value) => Center(
                                  child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.black),
                              )),
                            ),
                          ),
                        ),
                      );
                    },
                  );
          }),
    );
  }
}
