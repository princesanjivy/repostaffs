import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:flutter/material.dart';
import 'package:repostaffs/screens/internet_error_dialog.dart';

void changeScreen(BuildContext context, Widget screen) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ConnectivityWidget(
        showOfflineBanner: false,
        builder: (context, isOnline) {
          return isOnline ? screen : InternetErrorDialog();
        },
      ),
    ),
  );
}
