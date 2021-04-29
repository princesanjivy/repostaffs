import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repostaffs/components/my_text.dart';
import 'package:repostaffs/constants.dart';

class MyDropDown extends StatelessWidget {
  String choosenValue;

  @override
  Widget build(BuildContext context) {
    List t = ["A", "B", "C"]; //change this get from params
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      width: 225,
      decoration: BoxDecoration(
        color: PRIMARY,
        borderRadius: BorderRadius.circular(15),
      ),
      child: StatefulBuilder(builder: (context, setState) {
        return DropdownButton(
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
          items: t
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
        );
      }),
    );
  }
}
