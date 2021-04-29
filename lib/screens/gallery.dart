import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:repostaffs/components/my_appbar.dart';

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
          stream: FirebaseFirestore.instance.collection("gallery").snapshots(),
          builder: (context, gallerySnapshot) {
            if (!gallerySnapshot.hasData)
              return Center(child: CircularProgressIndicator());

            return GridView.builder(
              itemCount: gallerySnapshot.data.size,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15.0,
                  crossAxisSpacing: 3.0),
              itemBuilder: (context, index) {
                return Image.network(
                    gallerySnapshot.data.docs[index].get("url"));
              },
            );
          }),
    );
  }
}
