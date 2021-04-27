import 'package:flutter/material.dart';
import 'package:repostaffs/screens/upload_status.dart';
import 'package:repostaffs/components/my_text.dart';
import 'package:repostaffs/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDropDown extends StatefulWidget {
  @override
  _MyDropDownState createState() => _MyDropDownState();
  final List services;
  MyDropDown({this.services});
}

class _MyDropDownState extends State<MyDropDown> {
  String choosenValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      width: 225,
      decoration: BoxDecoration(
        color: PRIMARY,
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButton(
        underline: SizedBox(),
        icon: Icon(
          Icons.arrow_drop_down_circle_sharp,
        ),
        isExpanded: true,
        hint: MyText(
          'Select Service',
          fontWeight: 'MEDIUM',
          size: 18,
          color: WHITE,
        ),
        value: choosenValue,
        onChanged: (service) {
          setState(() {
            choosenValue = service;
          });
        },
        style: GoogleFonts.poppins(
          fontSize: 18,
          color: WHITE,
        ),
        iconEnabledColor: WHITE,
        focusColor: WHITE,
        items: widget.services
            .map(
              (service) => DropdownMenuItem(
                value: service,
                child: MyText(
                  service,
                  color: WHITE,
                  fontWeight: 'MEDIUM',
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
