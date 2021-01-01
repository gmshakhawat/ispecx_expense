import 'dart:io';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';

class ExcelHelper {
  var excel = Excel.createExcel();

  void create() {
    var sheet = excel['mySheet'];

    var cell = sheet.cell(CellIndex.indexByString("A1"));
    cell.value = "Heya How are you I am fine ok goood night";
    //cell.cellStyle = cellStyle;

    var cell2 = sheet.cell(CellIndex.indexByString("E5"));
    cell2.value = "Heya How night";
    // cell2.cellStyle = cellStyle;

    /// printing cell-type
    print("CellType: " + cell.cellType.toString());

    /// Iterating and changing values to desired type
    for (int row = 0; row < sheet.maxRows; row++) {
      sheet.row(row).forEach((cell) {
        var val = cell.value; //  Value stored in the particular cell

        cell.value = ' My custom Value ';
      });
    }

    //excel.rename("mySheet", "myRenamedNewSheet");

    // fromSheet should exist in order to sucessfully copy the contents
    // excel.copy('myRenamedNewSheet', 'toSheet');

    // excel.rename('oldSheetName', 'newSheetName');

    // excel.delete('Sheet1');

    // excel.unLink('sheet1');

    // sheet = excel['sheet'];

    /// appending rows
    List<List<String>> list = List.generate(
        60, (index) => List.generate(20, (index1) => '$index $index1'));

    Stopwatch stopwatch = new Stopwatch()..start();
    list.forEach((row) {
      print(row);
      sheet.appendRow(row);
    });

    print('doSomething() executed in ${stopwatch.elapsed}');

    sheet.appendRow([8]);
    excel.setDefaultSheet(sheet.sheetName).then((isSet) {
      // isSet is bool which tells that whether the setting of default sheet is successful or not.
      if (isSet) {
        print("${sheet.sheetName} is set to default sheet.");
      } else {
        print("Unable to set ${sheet.sheetName} to default sheet.");
      }
    });
  }

  Future save() async {
    Directory directory = await getApplicationDocumentsDirectory();

    print(directory.path);


    String cpath="/storage/emulated/0/Downloads";

    try {
      directory = await DownloadsPathProvider.downloadsDirectory;
    } on PlatformException {
      print('Could not get the downloads directory');
    }

    var es=excel.encode().then((onValue) {
      File(join("${directory.path}/evxcel.xlsx"))
        ..createSync(recursive: true)
        ..writeAsBytesSync(onValue);
    });

     print(directory.path);

    print(es);




  }
}
