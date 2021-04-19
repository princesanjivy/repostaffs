import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:repostaffs/components/my_appbar.dart';
import 'package:repostaffs/components/my_text.dart';
import 'package:repostaffs/components/row_text.dart';
import 'package:repostaffs/constants.dart';

class AddEditService extends StatefulWidget {
  @override
  _AddEditServiceState createState() => _AddEditServiceState();
}

class _AddEditServiceState extends State<AddEditService> {
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
                    .snapshots(),
                builder: (context, servicesSnapshot) {
                  if (!servicesSnapshot.hasData)
                    return Center(child: CircularProgressIndicator());

                  return ListView.builder(
                    itemCount: servicesSnapshot.data.size,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: MyRowText(
                          heading:
                              servicesSnapshot.data.docs[index].get("name"),
                          text: servicesSnapshot.data.docs[index].get("price"),
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
                  builder: (context) => AlertDialog(
                    title: MyText(
                      "Add a new service",
                      fontWeight: "SemiBold",
                    ),
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
                color: Colors.white,
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
