import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:repostaffs/components/fullscreen_view.dart';
import 'package:repostaffs/components/my_appbar.dart';
import 'package:repostaffs/components/my_text.dart';
import 'package:repostaffs/components/row_text.dart';
import 'package:repostaffs/constants.dart';

class StatusReport extends StatefulWidget {
  final String appBarTitle, profilePic, date, uid;

  StatusReport({
    this.date,
    this.appBarTitle,
    this.profilePic,
    this.uid,
  });

  @override
  _StatusReportState createState() => _StatusReportState();
}

class _StatusReportState extends State<StatusReport> {
  @override
  Widget build(BuildContext context) {
    print(widget.date);

    return Scaffold(
      appBar: MyAppBar("${widget.appBarTitle}'s Status"),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("status")
            .where("date", isEqualTo: widget.date)
            .where("uid", isEqualTo: widget.uid)
            .orderBy("customerName", descending: false)
            .snapshots(),
        builder: (context, statusSnapshot) {
          if (!statusSnapshot.hasData)
            return Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ));

          return statusSnapshot.data.size == 0
              ? Center(
                  child: MyText(
                    "No services done",
                    color: WHITE,
                  ),
                )
              : PageView.builder(
                  itemCount: statusSnapshot.data.size,
                  itemBuilder: (context, pageIndex) {
                    String services = "";
                    List serviceData =
                        statusSnapshot.data.docs[pageIndex].get("services");
                    for (int i = 0; i < serviceData.length; i++) {
                      if (i != serviceData.length - 1)
                        services += serviceData[i]["name"] + ', ';
                      else
                        services += serviceData[i]["name"] + '. ';
                    }
                    return ListView(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: SizedBox(
                              width: 130,
                              height: 130,
                              child: Image.network(
                                widget.profilePic,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        MyRowText(
                          heading: "Customer Name :",
                          text: statusSnapshot.data.docs[pageIndex]
                                      .get("customerName") ==
                                  ""
                              ? "Not given"
                              : statusSnapshot.data.docs[pageIndex]
                                  .get("customerName"),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        MyRowText(
                          heading: "Customer Ph.No :",
                          text: statusSnapshot.data.docs[pageIndex]
                                      .get("customerPhoneNo") ==
                                  ""
                              ? "Not given"
                              : statusSnapshot.data.docs[pageIndex]
                                  .get("customerPhoneNo"),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        MyRowText(
                          heading: "Services taken :",
                          text: services,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (statusSnapshot.data.docs[pageIndex]
                                    .get('customerPhotos')
                                    .length !=
                                0)
                              StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("gallery")
                                    .doc(statusSnapshot.data.docs[pageIndex]
                                        .get("customerPhotos")[0])
                                    .snapshots(),
                                builder: (context, image) {
                                  if (!image.hasData)
                                    return Center(
                                        child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.black),
                                    ));

                                  return Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color: SECONDARY,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                FullScreenView(
                                              child: Image.network(
                                                image.data.get('url'),
                                                fit: BoxFit.cover,
                                              ),
                                              title: statusSnapshot
                                                  .data.docs[pageIndex]
                                                  .get('customerName'),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: WHITE, width: 1),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  image.data.get("url")),
                                              fit: BoxFit.fill,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        width: 150,
                                        height: 200,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            SizedBox(
                              width: 5.0,
                            ),
                            if (statusSnapshot.data.docs[pageIndex]
                                    .get('customerPhotos')
                                    .length >
                                1)
                              StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("gallery")
                                    .doc(statusSnapshot.data.docs[pageIndex]
                                        .get("customerPhotos")[0])
                                    .snapshots(),
                                builder: (context, image) {
                                  if (!image.hasData)
                                    return Center(
                                        child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.black),
                                    ));

                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => FullScreenView(
                                            child: Image.network(
                                              image.data.get('url'),
                                              fit: BoxFit.cover,
                                            ),
                                            title: statusSnapshot
                                                .data.docs[pageIndex]
                                                .get('customerName'),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: WHITE, width: 1),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                image.data.get("url")),
                                            fit: BoxFit.fill,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      width: 150,
                                      height: 200,
                                    ),
                                  );
                                },
                              ),
                          ],
                        ),
                      ],
                    );
                  },
                );
        },
      ),
    );
  }
}
