import 'package:flutter/material.dart';
import 'package:repostaffs/components/my_appbar.dart';
import 'package:repostaffs/components/my_text.dart';

class StaffStatusAdmin extends StatefulWidget {
  @override
  _StaffStatusAdminState createState() => _StaffStatusAdminState();
}

class _StaffStatusAdminState extends State<StaffStatusAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("Staff's Status"),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Container(
          child: MyText(
            "Rebaca",
            fontWeight: "Light",
            size: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
