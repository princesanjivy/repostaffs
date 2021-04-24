import 'package:flutter/material.dart';
import 'package:repostaffs/components/my_appbar.dart';
import 'package:repostaffs/components/row_text.dart';

class StatusReport extends StatefulWidget {
  @override
  _StatusReportState createState() => _StatusReportState();
}

class _StatusReportState extends State<StatusReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("Prince's Status"),
      body: PageView.builder(
          itemCount: 5,
          itemBuilder: (context, pageIndex) {
            return ListView(
              padding: EdgeInsets.symmetric(vertical: 16),
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: SizedBox(
                      width: 130,
                      height: 130,
                      child: Image.network(
                        "https://images.unsplash.com/photo-1618374509394-3606c0aaf289?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                MyRowText(
                  heading: "Customer Name",
                  text: "Prince Sanjivy",
                ),
                SizedBox(
                  height: 16,
                ),
                MyRowText(
                  heading: "Customer Ph.No",
                  text: "+91 9443376775",
                ),
                SizedBox(
                  height: 16,
                ),
                MyRowText(
                  heading: "Services taken",
                  text: "Hair wash, shaving, facial",
                ),
                SizedBox(
                  height: 16,
                ),

                //   SingleChildScrollView(
                //     scrollDirection: Axis.horizontal,
                //     child: Padding(
                //       padding: EdgeInsets.symmetric(horizontal: 8),
                //       child: Row(
                //         children: [
                //           Padding(
                //             padding: EdgeInsets.only(
                //               left: 8,
                //               top: 16,
                //               bottom: 16,
                //               right: 8,
                //             ),
                //             child: ClipRRect(
                //               borderRadius: BorderRadius.circular(15),
                //               child: Image.network(
                //                 "https://images.unsplash.com/photo-1618374509394-3606c0aaf289?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
                //                 height: 150,
                //                 width: 260,
                //                 fit: BoxFit.cover,
                //               ),
                //             ),
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(
                //               left: 8,
                //               top: 16,
                //               bottom: 16,
                //               right: 8,
                //             ),
                //             child: ClipRRect(
                //               borderRadius: BorderRadius.circular(15),
                //               child: Image.network(
                //                 "https://images.unsplash.com/photo-1618374509394-3606c0aaf289?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
                //                 height: 150,
                //                 width: 260,
                //                 fit: BoxFit.cover,
                //               ),
                //             ),
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(
                //               left: 8,
                //               top: 16,
                //               bottom: 16,
                //               right: 8,
                //             ),
                //             child: ClipRRect(
                //               borderRadius: BorderRadius.circular(15),
                //               child: Image.network(
                //                 "https://images.unsplash.com/photo-1618374509394-3606c0aaf289?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
                //                 height: 150,
                //                 width: 260,
                //                 fit: BoxFit.cover,
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
              ],
            );
          }),
    );
  }
}
