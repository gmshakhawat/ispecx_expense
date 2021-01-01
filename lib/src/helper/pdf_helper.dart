import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class CreatePDF {
  final pdf = pw.Document();

  Future create() async {
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text("Hello World"),
          ); // Center
        })); // Page

    Directory tempDir = await getApplicationDocumentsDirectory();
    String path=tempDir.path;
    final File file = File("$path/myFile.pdf");

    print(tempDir.path.toString());

   // final file = File("example.pdf");
    file.writeAsBytes(pdf.save());
  }
}
