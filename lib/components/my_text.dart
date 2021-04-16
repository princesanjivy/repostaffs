import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  final String text;
  final double size;
  final String fontWeight;
  final Color color;

  MyText(
    this.text, {
    this.size,
    this.fontWeight,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    FontWeight fontWeight;
    switch (this.fontWeight) {
      case "Light":
        fontWeight = FontWeight.w300;
        break;
      case "Medium":
        fontWeight = FontWeight.w500;
        break;
      case "SemiBold":
        fontWeight = FontWeight.w600;
        break;
    }

    return Text(
      text,
      style: GoogleFonts.poppins(
        fontWeight: fontWeight,
        fontSize: size,
        color: color,
      ),
    );
  }
}
