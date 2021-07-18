import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repostaffs/components/my_appbar.dart';
import 'package:repostaffs/components/my_text.dart';
import 'package:repostaffs/constants.dart';

class AddEditService extends StatefulWidget {
  @override
  _AddEditServiceState createState() => _AddEditServiceState();
}

class _AddEditServiceState extends State<AddEditService> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  List services = [
    "Men",
    "Women",
    "Color & Treatment",
    "Facials",
    "Body",
  ];

  String selectedCategory = "Men";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("Services"),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView.builder(
            itemCount: services.length,
            itemBuilder: (context, index) {
              return ExpansionTile(
                title: MyText(
                  services[index],
                  size: 20,
                  color: Colors.white,
                ),
                collapsedIconColor: Colors.white,
                childrenPadding: EdgeInsets.all(8),
                iconColor: Colors.white,
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("services")
                        .where("category", isEqualTo: services[index])
                        .orderBy("name")
                        .snapshots(),
                    builder: (context, servicesSnapshot) {
                      if (!servicesSnapshot.hasData)
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.black),
                          ),
                        );

                      return servicesSnapshot.data.size == 0
                          ? Center(
                              child: MyText(
                                "No services added",
                                color: Colors.white,
                                fontWeight: "Light",
                              ),
                            )
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: servicesSnapshot.data.size,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {},
                                  title: MyText(
                                    servicesSnapshot.data.docs[index]
                                        .get("name"),
                                    color: Colors.white,
                                  ),
                                  subtitle: MyText(
                                    "₹" +
                                        servicesSnapshot.data.docs[index]
                                            .get("price"),
                                    color: Colors.white,
                                  ),
                                  trailing: IconButton(
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection("services")
                                          .doc(servicesSnapshot
                                              .data.docs[index].id)
                                          .delete();
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              },
                            );
                    },
                  ),
                ],
              );
            },
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => StatefulBuilder(
                    builder: (context, setState) {
                      return AlertDialog(
                        title: MyText(
                          "Add a new service",
                          fontWeight: "SemiBold",
                        ),
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DropdownButton(
                              hint: MyText("Select category"),
                              isExpanded: true,
                              value: selectedCategory,
                              dropdownColor: Colors.white,
                              onChanged: (value) {
                                setState(() {
                                  selectedCategory = value;
                                });
                              },
                              items: services
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: MyText(e),
                                    ),
                                  )
                                  .toList(),
                            ),
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
                                  "category": selectedCategory.toString(),
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
                      );
                    },
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
