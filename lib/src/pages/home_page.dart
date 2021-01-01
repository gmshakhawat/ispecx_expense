import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ispecx_expense/src/controllers/image_text_controller.dart';
import 'package:ispecx_expense/src/helper/excel_helper.dart';
import 'package:ispecx_expense/src/helper/pdf_helper.dart';
import 'package:ispecx_expense/src/pages/camera.dart';
import 'package:ispecx_expense/src/pages/dashboard_page.dart';
import 'package:ispecx_expense/src/pages/receipts_page.dart';
import 'package:ispecx_expense/src/services/text_request_service.dart';
import 'package:ispecx_expense/test.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  //  final CameraDescription camera;
  //  const HomePage({
  //   Key key,
  //   @required this.camera,
  // }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _title = "Receipts";
  bool isCal = false;

  DashBoard dashBoard;
  Receipts receipts;

  var _page;
//CameraController _controller;
  //Future<void> _initializeControllerFuture;
  @override
  void initState() {
    // TODO: implement initState

    dashBoard = DashBoard();
    receipts = Receipts();

    _page = receipts;

    // _controller = CameraController(
    //   // Get a specific camera from the list of available cameras.
    //   widget.camera,
    //   // Define the resolution to use.
    //   ResolutionPreset.medium,
    // );

    // Next, initialize the controller. This returns a Future.
    // _initializeControllerFuture = _controller.initialize();

    super.initState();
  }

  bool _isCam = false;

  ImageTextController imageTextController = Get.put(ImageTextController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        backgroundColor: Colors.grey.shade900,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async{
              print(value);
              if(value=="PDF"){
                 bool res=true;
                 CreatePDF().create();

                 print(res.toString());
              }
              if(value=="Excel"){
                 bool res=true;
                 ExcelHelper().create();

                 var status = await Permission.storage.status;
                  if (!status.isGranted) {
                    await Permission.storage.request();
                  }
                  else{

                    print(status.toString());
                    ExcelHelper().save();
                  }

                 

                 print(res.toString());
              }
            },
            
            itemBuilder: (BuildContext contx) {
            
            return [
              PopupMenuItem(child: Row(children: [Icon(Icons.picture_as_pdf,color: Colors.black,),SizedBox(width: 15,), Text("Export PDF",)]),value: "PDF",),
              PopupMenuItem(child: Row(children: [Icon(Icons.explicit,color: Colors.black,),SizedBox(width: 15,), Text("Export Excel",)]),value: "Excel",),

              
            ];
          })
        ],
      ),
      body: _page,
      floatingActionButton: new FloatingActionButton(
        child: new Icon(
          Icons.camera_alt,
          size: 35,
        ),
        backgroundColor: Colors.green,
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.

          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CameraPage()));

          // setState(() {
          //   _isCam=true;
          // });
          // try {
          //   // Ensure that the camera is initialized.
          //   await _initializeControllerFuture;

          //   // Construct the path where the image should be saved using the
          //   // pattern package.
          //   final path = join(
          //     // Store the picture in the temp directory.
          //     // Find the temp directory using the `path_provider` plugin.
          //     (await getTemporaryDirectory()).path,
          //     '${DateTime.now()}.png',
          //   );

          //   // Attempt to take a picture and log where it's been saved.
          //   await _controller.takePicture();

          //   // If the picture was taken, display it on a new screen.
          //   // Navigator.push(
          //   //   context,
          //   //   MaterialPageRoute(
          //   //     builder: (context) => DisplayPictureScreen(imagePath: path),
          //   //   ),
          //   // );
          // } catch (e) {
          //   // If an error occurs, log the error to the console.
          //   print(e);
          // }
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              color: Colors.grey.shade900,
              height: 80,
              child: DrawerHeader(
                child: Text(
                  'Ispecx Expense',
                  style: TextStyle(fontSize: 23, color: Colors.white),
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Receipts',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              onTap: () {
                setState(() {
                  _title = "Receipts";
                  _page = receipts;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                'Dashboard',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              onTap: () {
                setState(() {
                  _title = "Dashboard";
                  _page = dashBoard;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
