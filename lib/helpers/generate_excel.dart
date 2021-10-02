import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:repostaffs/helpers/format_date.dart';

class GenerateExcel {
  final DateTime dateTime;
  GenerateExcel(this.dateTime);

  static const platform =
      const MethodChannel('com.princeappstudio.repostaffs/save');

  save(List<QueryDocumentSnapshot> docs, Map staffName,
      BuildContext context) async {
    var excel = Excel.createExcel();
    Map<String, List> data = {};
    List rows = [
      "Service Name",
      "Date",
      "Customer Name",
      "Customer Phone",
      "Price",
    ];

    for (String uid in staffName.keys) {
      List d = [];
      for (int j = 0; j < docs.length; j++) {
        if (uid == docs[j].get("uid")) {
          d.add(docs[j].data());
        }
      }
      data.addAll({staffName[uid]: d});
    }

    for (String name in data.keys) {
      int row = 0;
      excel.insertRowIterables(
        name,
        rows,
        row,
      );

      for (int i = 0; i < data[name].length; i++) {
        List t = data[name][i]["services"];

        for (int j = 0; j < t.length; j++) {
          excel.insertRowIterables(
            name,
            [
              t[j]["name"],
              DateFormat.yMd()
                  .format(
                    DateFormat("yMMMMEEEEd").parse(
                      data[name][i]["date"],
                    ),
                  )
                  .toString(),
              data[name][i]["customerName"],
              data[name][i]["customerPhoneNo"],
              int.parse(t[j]["price"]),
            ],
            row,
          );
          row += 1;
        }
      }
    }

    excel.delete("Sheet1");

    List headings = ["Date", "Pos1", "Cash1", "Pos2", "Cash2", "Expenses"];

    excel.insertRowIterables(
      "Sales",
      headings,
      0,
    );
    headings.asMap().forEach((index, value) {
      excel.updateCell(
        "Sales",
        CellIndex.indexByColumnRow(
          columnIndex: index,
          rowIndex: 0,
        ),
        headings[index],
        cellStyle: CellStyle(backgroundColorHex: "#C6EFCE"),
      );
    });
    await FirebaseFirestore.instance
        .collection("sales")
        .orderBy("date")
        .get()
        .then((value) {
      value.docs.asMap().forEach((index, element) {
        excel.insertRowIterables(
            "Sales",
            [
              DateTime.fromMillisecondsSinceEpoch(element.data()["date"])
                  .toString(),
              element.data()["pos1"],
              element.data()["cash1"],
              element.data()["pos2"],
              element.data()["cash2"],
              element.data()["expenses"],
            ],
            index + 1);
      });
    });

    for (String name in data.keys) {
      for (int i = 0; i < rows.length; i++) {
        excel.updateCell(
          name,
          CellIndex.indexByColumnRow(
            columnIndex: i,
            rowIndex: 0,
          ),
          rows[i],
          cellStyle: CellStyle(backgroundColorHex: "#C6EFCE"),
        );
      }
    }

    // var excel = Excel.createExcel();
    // excel.insertRowIterables("Sheet1", ["Hair cut", "Beard trim"], 0);
    // excel.updateCell(
    //   "Prince",
    //   CellIndex.indexByString("A2"),
    //   "Sanjivy",
    //   cellStyle: CellStyle(backgroundColorHex: "#C6EFCE"),
    // );
    // excel.updateCell(
    //   "Prince",
    //   CellIndex.indexByString("B2"),
    //   "Hendrix",
    //   cellStyle: CellStyle(backgroundColorHex: "#C6E00E"),
    // );
    // excel.updateCell(
    //   "Hendrix",
    //   CellIndex.indexByString("B2"),
    //   "Hendrix",
    //   cellStyle: CellStyle(backgroundColorHex: "#C6E00E"),
    // );
    //
    Uint8List bytes;

    String dir = (await getTemporaryDirectory()).path;
    File temp = new File('$dir/temp.xlsx');

    await temp.writeAsBytes(excel.save());
    bytes = temp.readAsBytesSync();
    temp.delete();

    String dt = dateToString(DateTime.now());
    dt = dt.substring(dt.indexOf(", ") + 1, dt.length).trim();
    print(dt);
    dt = dt.substring(0, dt.indexOf(" ")).trim();

    try {
      Navigator.pop(context);

      await platform.invokeMethod(
        'excel',
        {
          "bytes": bytes,
          "name": dt + " services",
        },
      ).then((value) {
        print(value);
      });
    } on PlatformException catch (e) {
      Navigator.pop(context);

      print(e.message);
    }
  }
}
