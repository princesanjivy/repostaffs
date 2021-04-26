import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repostaffs/components/my_appbar.dart';
import 'package:repostaffs/components/my_text.dart';
import 'package:repostaffs/constants.dart';

class UploadStatus extends StatefulWidget {
  @override
  _UploadStatusState createState() => _UploadStatusState();
}

class _UploadStatusState extends State<UploadStatus> {
  List services = [
    'Haircut',
    'Pedicure',
    'Hair Spa',
    'Hair Coloring',
  ];

  TextEditingController _customerName = new TextEditingController();
  TextEditingController _mobNo = new TextEditingController();
  int count = 1;
  String choosenValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar('Service Status'),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
            ),
            Center(
              child: Container(
                width: 270,
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    prefixIcon: Icon(
                      Icons.person,
                      color: WHITE,
                    ),
                    labelText: 'Customer Name',
                    labelStyle: GoogleFonts.poppins(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300,
                      color: WHITE,
                      letterSpacing: 1.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: PRIMARY,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: WHITE,
                      ),
                    ),
                    hintText: 'Customer Name',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.white38,
                      letterSpacing: 1.0,
                    ),
                  ),
                  style: GoogleFonts.poppins(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300,
                    color: WHITE,
                    letterSpacing: 1.0,
                  ),
                  controller: _customerName,
                  autocorrect: true,
                  cursorColor: WHITE,
                ),
              ),
            ),
            SizedBox(
              height: 35.0,
            ),
            Center(
              child: Container(
                width: 270,
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    prefixIcon: Icon(
                      Icons.call_rounded,
                      color: WHITE,
                    ),
                    labelText: 'Customer Ph.No',
                    labelStyle: GoogleFonts.poppins(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300,
                      color: WHITE,
                      letterSpacing: 1.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: PRIMARY,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: WHITE,
                      ),
                    ),
                    hintText: 'Customer Ph.No',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.white38,
                      letterSpacing: 1.0,
                    ),
                  ),
                  style: GoogleFonts.poppins(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300,
                    color: WHITE,
                    letterSpacing: 1.0,
                  ),
                  controller: _mobNo,
                  autocorrect: true,
                  cursorColor: WHITE,
                ),
              ),
            ),
            SizedBox(
              height: 35.0,
            ),
            ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: count,
              itemBuilder: (context, index) => Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        index == 0
                            ? SizedBox(
                                width: 20.0,
                              )
                            : SizedBox(
                                width: 70,
                              ),
                        index == 0
                            ? IconButton(
                                icon: Icon(
                                  Icons.remove,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (count > 1) count--;
                                  });
                                })
                            : Container(),
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          width: 225,
                          decoration: BoxDecoration(
                            color: PRIMARY,
                            border: Border.all(
                              color: WHITE,
                              width: 1,
                            ),
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
                            items: services
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
                        ),
                        index == 0
                            ? IconButton(
                                icon: Icon(
                                  Icons.add_box,
                                ),
                                onPressed: () {
                                  setState(() {
                                    count++;
                                  });
                                })
                            : Container(),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 200,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {},
                style: ButtonStyle(
                  // elevation: MaterialStateProperty.all<double>(15),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(19),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(Size(120, 55)),
                  backgroundColor: MaterialStateProperty.all((PRIMARY)),
                ),
                child: MyText(
                  'Update Status',
                  color: WHITE,
                  fontWeight: 'Light',
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
