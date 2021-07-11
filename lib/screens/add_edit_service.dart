import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repostaffs/components/my_appbar.dart';
import 'package:repostaffs/components/my_text.dart';
import 'package:repostaffs/components/row_text.dart';
import 'package:repostaffs/constants.dart';

class AddEditService extends StatefulWidget {
  @override
  _AddEditServiceState createState() => _AddEditServiceState();
}

class _AddEditServiceState extends State<AddEditService> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("Services"),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("services")
                    .orderBy("name")
                    .snapshots(),
                builder: (context, servicesSnapshot) {
                  if (!servicesSnapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                    );

                  return servicesSnapshot.data.size == 0
                      ? Center(
                          child: MyText(
                            "No services added",
                            color: WHITE,
                            fontWeight: "Light",
                          ),
                        )
                      : ListView.builder(
                          itemCount: servicesSnapshot.data.size,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection("services")
                                          .doc(servicesSnapshot
                                              .data.docs[index].id)
                                          .delete();
                                    },
                                    icon: Icon(Icons.close),
                                  ),
                                  MyRowText(
                                    heading: servicesSnapshot.data.docs[index]
                                        .get("name"),
                                    text: "₹" +
                                        servicesSnapshot.data.docs[index]
                                            .get("price"),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                }),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AlertDialog(
                    title: MyText(
                      "Add a new service",
                      fontWeight: "SemiBold",
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: "Service Name",
                            labelStyle: GoogleFonts.poppins(),
                          ),
                          style: GoogleFonts.poppins(),
                        ),
                        TextField(
                          controller: _priceController,
                          decoration: InputDecoration(
                            labelText: "Price",
                            labelStyle: GoogleFonts.poppins(),
                          ),
                          style: GoogleFonts.poppins(),
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: MyText(
                          "CANCEL",
                          color: PRIMARY,
                          fontWeight: "Medium",
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection("services")
                              .add(
                            {
                              "name": _nameController.text,
                              "price": _priceController.text,
                            },
                          );

                          Navigator.pop(context);
                          _nameController.clear();
                          _priceController.clear();
                        },
                        child: MyText(
                          "ADD",
                          color: PRIMARY,
                          fontWeight: "Medium",
                        ),
                      ),
                    ],
                  ),
                );
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                minimumSize: MaterialStateProperty.all<Size>(Size(120, 55)),
                backgroundColor: MaterialStateProperty.all(PRIMARY),
              ),
              child: MyText(
                'Add new service',
                color: WHITE,
                fontWeight: 'Light',
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
