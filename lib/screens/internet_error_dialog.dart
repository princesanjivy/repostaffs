import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repostaffs/constants.dart';

class InternetErrorDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: AlertDialog(
        backgroundColor: WHITE,
        content: Text(
          'Unable to connect to the Internet. Please check your connection and try again!',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: PRIMARY,
          ),
        ),
        title: Text(
          'No Internet Connection',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: PRIMARY,
          ),
        ),
      ),
    ));
  }
}
