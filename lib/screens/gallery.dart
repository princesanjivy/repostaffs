import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:repostaffs/components/my_appbar.dart';
import 'package:repostaffs/components/my_text.dart';
import 'package:repostaffs/constants.dart';

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("Gallery"),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("gallery")
              .orderBy("customerName")
              .snapshots(),
          builder: (context, gallerySnapshot) {
            if (!gallerySnapshot.hasData)
              return Center(child: CircularProgressIndicator());

            return GridView.builder(
              padding: EdgeInsets.all(8),
              itemCount: gallerySnapshot.data.size,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return GridTile(
                  child: Image.network(
                    gallerySnapshot.data.docs[index].get("url"),
                    fit: BoxFit.cover,
                  ),
                  footer: Center(
                    child: MyText(
                      gallerySnapshot.data.docs[index].get("customerName"),
                      color: WHITE,
                      fontWeight: "Medium",
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
