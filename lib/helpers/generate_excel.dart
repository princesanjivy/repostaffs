import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class GenerateExcel {
  final DateTime dateTime;

  GenerateExcel(this.dateTime);

  save() async {
    PermissionStatus status = await Permission.storage.status;
    if (status.isGranted) {
      final folderName = "Repo";
      final path = Directory("storage/emulated/0/$folderName");
      if ((await path.exists())) {
        // TODO:
        print("exist");
      } else {
        // TODO:
        print("not exist");
        path.create();
      }
    } else {
      await Permission.storage.request();
    }
  }
}
