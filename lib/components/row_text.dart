import 'package:flutter/material.dart';
import 'package:repostaffs/components/my_text.dart';

class MyRowText extends StatelessWidget {
  final String heading;
  final String text;

  MyRowText({
    this.heading,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: MyText(
              heading,
              size: 18,
              color: Colors.white,
            ),
          ),
          // Expanded(
          //   child: MyText(
          //     " : ",
          //     size: 18,
          //     color: Colors.white,
          //   ),
          // ),
          Expanded(
            child: MyText(
              text,
              size: 18,
              fontWeight: "Light",
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
