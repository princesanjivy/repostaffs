import 'dart:io';
import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class GenerateExcel {
  final DateTime dateTime;
  GenerateExcel(this.dateTime);

  static const platform =
      const MethodChannel('com.princeappstudio.repostaffs/save');

  save() async {
    var excel = Excel.createExcel();
    excel.insertRowIterables("Sheet1", ["Hair cut", "Beard trim"], 0);
    excel.updateCell(
      "Sheet1",
      CellIndex.indexByString("A2"),
      "Sanjivy",
      cellStyle: CellStyle(backgroundColorHex: "#C6EFCE"),
    );
    excel.updateCell( 
      "Sheet1",
      CellIndex.indexByString("B2"),
      "Hendrix",
      cellStyle: CellStyle(backgroundColorHex: "#C6E00E"),
    );

    Uint8List bytes;

    String dir = (await getTemporaryDirectory()).path;
    File temp = new File('$dir/temp.xlsx');

    await temp.writeAsBytes(excel.save());
    bytes = temp.readAsBytesSync();
    temp.delete();

    try {
      await platform.invokeMethod(
        'excel',
        {
          "bytes": bytes,
          "name": DateTime.now().millisecondsSinceEpoch.toString(),
        },
      ).then((value) {
        print(value);
      });
    } on PlatformException catch (e) {
      print(e.message);
    }
  }
}
