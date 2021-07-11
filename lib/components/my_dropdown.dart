import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repostaffs/components/my_text.dart';
import 'package:repostaffs/constants.dart';

List selectedServices = [];

class MyDropDown extends StatelessWidget {
  List services;
  int stateIndexx;
  MyDropDown({this.services, this.stateIndexx});
  String choosenValue = 'Select Service';
  String priceVal = 'None';
  bool notextField = false;
  bool showHint = false;

  List listOfServices = [
    "Men",
    "Women",
    "Color & Treatment",
    "Facials",
    "Body",
  ];

  TextEditingController _priceCon = TextEditingController();

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
                        style: GoogleFonts.poppins(fontSize: 18, color: WHITE),
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: showHint ? priceVal : '',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 18,
                            color: WHITE,
                          ),
                          contentPadding: EdgeInsets.all(9),
                          labelStyle: GoogleFonts.poppins(
                            color: WHITE,
                            fontSize: 18,
                          ),
                          border: InputBorder.none,
                        ),
                        controller: _priceCon,
                        onChanged: (myPrice) {
                          // print(ind);
                          if (myPrice.isNotEmpty)
                            selectedServices[stateIndexx] = {
                              'name': choosenValue,
                              'price': myPrice
                            };
                          else if (myPrice.isEmpty) {
                            setState(() {
                              showHint = true;
                            });
                            selectedServices[stateIndexx] = {
                              'name': choosenValue,
                              'price': priceVal
                            };
                          }
                        },
                      ),
                    ),
                  ),
                ],
              )
            : DropdownButton(
                underline: SizedBox(),
                icon: Icon(
                  Icons.arrow_drop_down_circle_sharp,
                ),
                isExpanded: true,
                value: "Men",
                onChanged: (service) {
                  // print(ind);
                  if (service != 'Select Service') {
                    setState(() {
                      for (int i = 0; i < services.length; i++) {
                        if (service == services[i]['name']) {
                          priceVal = services[i]['price'];
                          choosenValue = services[i]['name'];
                          _priceCon.text = priceVal;
                        }
                      }
                      notextField = true;
                    });
                    selectedServices
                        .add({'name': choosenValue, 'price': _priceCon.text});
                  }
                },
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: WHITE,
                ),
                iconEnabledColor: WHITE,
                focusColor: WHITE,
                items: listOfServices
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: MyText(e),
                      ),
                    )
                    .toList(),
                // items: services
                //         .map(
                //           (service) => DropdownMenuItem(
                //             value: service['name'],
                //             child: MyText(
                //               service['name'],
                //               color: WHITE,
                //               fontWeight: 'MEDIUM',
                //             ),
                //           ),
                //         )
                //         .toList() ??
                //     [],
              );
      }),
    );
  }
}
