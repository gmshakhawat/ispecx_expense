import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/foundation.dart';
import 'package:ispecx_expense/src/controllers/image_text_controller.dart';
import 'package:ispecx_expense/src/helper/receipt_helper.dart';
import 'package:ispecx_expense/src/widgets/recept_short.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  PickedFile _imageFile;
  dynamic _pickImageError;
  String _retrieveDataError;
  int img = 0;

  final ImagePicker _picker = ImagePicker();

  ImageTextController imageTextController = Get.find();

  File _image;

  void getImageF() async {
    try {
      final pickedFile = await _picker.getImage(
        maxHeight: 750,
        maxWidth: 750,
        imageQuality: 100,
        source: ImageSource.gallery,
      );

      setState(() => _imageFile = pickedFile);

      String base64Image =
          base64Encode(File(_imageFile.path).readAsBytesSync());

      imageTextController.convertBase64(base64Image);

      // _cropImage();

      // setState(() {
      //   print('Picked______');
      //    print('____'+img.toString()+'='+pickedFile.path);
      //    img+=1;
      //   _imageFile = pickedFile;
      //   print('____'+img.toString()+'='+_imageFile.path);
      // });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      //_imageFile = croppedFile;
      setState(() {
        String base64Image =
            base64Encode(File(croppedFile.path).readAsBytesSync());
        imageTextController.setStatus(false);
        imageTextController.lastReceipt.refresh();
        imageTextController.convertBase64(base64Image);
      });
    }
  }


  @override
  void initState() {
    // TODO: implement initState

    getImageF();
   


    super.initState();
  }

  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        title: Text(
          "Receipts",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey.shade800,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text("Image"),

          // SizedBox(height: 5,),

          Obx(
            () => imageTextController.isImage.value == false
                ? Container(
                    height: 90,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(width: 3.0, color: Colors.grey.shade900),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Scanning ... , Please Wait !!!",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.start,
                      ),
                    ))
                : receipt_short(imageTextController.lastReceipt.value),
          ),

          Container(
            height: 120,
            color: Colors.grey.shade900,
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      size: 60,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      getImageF();
                    }),
                SizedBox(
                  width: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: 90,
                      child: _imageFile != null
                          ? Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                _previewImage(),
                                IconButton(
                                    icon: Icon(
                                      Icons.remove_circle,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      getImageF();
                                    })
                              ],
                            )
                          : Text("No Image")),
                ),
              ],
            ),
          ),

          //  FutureBuilder<void>(
          //           future: retrieveLostData(),
          //           builder: (BuildContext context, AsyncSnapshot<void> snapshot) {

          //             switch (snapshot.connectionState) {
          //               case ConnectionState.none:
          //               case ConnectionState.waiting:

          //               case ConnectionState.done:
          //                  // print('Done____');

          //                  return _previewImage();

          //               default:
          //                 if (snapshot.hasError) {
          //                   return Text(
          //                     'Pick image/video error: ${snapshot.error}}',
          //                     textAlign: TextAlign.center,
          //                   );
          //                 } else {

          //                   print('Deafult____');

          //                   return _previewImage();

          //                 }
          //             }
          //           },
          //         )
        ],
      ),
    );
  }

  Widget _previewImage() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile != null) {
      print('____Image Priont 1st ____');
      if (kIsWeb) {
        // Why network?
        // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform

        return Image.network(
          _imageFile.path,
          height: 100.0,
          width: 60.0,
        );
      } else {
        //imageTextController.convertBase64(_imageFile);
        return ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.file(
              File(_imageFile.path),
              height: 100.0,
              width: 60.0,
              fit: BoxFit.fill,
            ));
      }
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    }
  }

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        print('____LostData ____' + img.toString());
        img += 1;
        _imageFile = response.file;
      });
    } else {
      _retrieveDataError = response.exception.code;
    }
  }
}
