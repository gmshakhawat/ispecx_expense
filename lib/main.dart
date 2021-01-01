import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ispecx_expense/src/pages/home_page.dart';
import 'package:camera/camera.dart';

Future<void>  main() async{


   WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(MyApp(camera: firstCamera,));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
   final CameraDescription camera;
   const MyApp({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ispecx Expense',
      theme: ThemeData(
          canvasColor: Colors.black,
        //primaryColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
