import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repostaffs/components/my_text.dart';
import 'package:repostaffs/constants.dart';

class MyDropDown extends StatelessWidget {
  List services;
  MyDropDown({this.services});
  String choosenValue = 'Select Service';
  String priceVal = 'None';
  bool notextField = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      width: 225,
      decoration: BoxDecoration(
        color: PRIMARY,
        borderRadius: BorderRadius.circular(15),
      ),
      child: StatefulBuilder(builder: (context, setState) {
        return (notextField)
            ? Row(
                children: [
                  MyText(
                    choosenValue,
                    color: WHITE,
                    size: 18,
                  ),
                  Expanded(
                    child: Container(
                      width: 225,
                      child: TextField(
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(9),
                          hintText: priceVal,
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 18,
                            color: WHITE,
                          ),
                          labelStyle: GoogleFonts.poppins(
                            color: WHITE,
                            fontSize: 18,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  )
                ],
              )
            : DropdownButton(
                underline: SizedBox(),
                icon: Icon(
                  Icons.arrow_drop_down_circle_sharp,
                ),
                isExpanded: true,
                // hint: MyText(
                //   'Select Service',
                //   fontWeight: 'MEDIUM',
                //   size: 18,
                //   color: WHITE,
                // ),
                value: 'Select Service',
                onChanged: (service) {
                  if (service != 'Select Service') {
                    setState(() {
                      for (int i = 0; i < services.length; i++) {
                        if (service == services[i]['name']) {
                          priceVal = services[i]['price'];
                          choosenValue = services[i]['name'];
                        }
                      }
                      notextField = true;
                    });
                  }

                  print(service);
                },
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: WHITE,
                ),
                iconEnabledColor: WHITE,
                focusColor: WHITE,
                items: services
                        .map(
                          (service) => DropdownMenuItem(
                            value: service['name'],
                            child: MyText(
                              service['name'],
                              color: WHITE,
                              fontWeight: 'MEDIUM',
                            ),
                          ),
                        )
                        .toList() ??
                    [],
              );
      }),
    );
  }
}
