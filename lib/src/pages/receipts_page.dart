import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ispecx_expense/src/controllers/image_text_controller.dart';
import 'package:ispecx_expense/src/helper/receipt_helper.dart';
import 'package:ispecx_expense/src/models/receipts_model.dart';
import 'package:ispecx_expense/src/widgets/recept_short.dart';
import 'package:path/path.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Receipts extends StatefulWidget {
  @override
  _ReceiptsState createState() => _ReceiptsState();
}

class _ReceiptsState extends State<Receipts> {
 
  ReceiptHelper _receiptHelper=ReceiptHelper();

 Future< List<ReceiptsModel>> _receiptsList;

 ImageTextController _imageTextController=Get.find();



  @override
  void initState() {
    // TODO: implement initState


    _receiptHelper.initializeDatabase().then((value) {

      print("====Inititalized===");

      _receiptsList=_receiptHelper.getReceiptsData();

      loadReceipts();



    });

    
    super.initState();
  }

  void loadReceipts() {
    _receiptsList = _receiptHelper.getReceiptsData();
    
    
    if (mounted) setState(() {});
  }


   @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
       // onResumed();
       print("Resume");
        break;
      case AppLifecycleState.inactive:
      //  onPaused();
        break;
      case AppLifecycleState.paused:
       // onInactive();
       print("Resume");

        break;
      case AppLifecycleState.detached:
      //  onDetached();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ToggleSwitch(
              minWidth: Get.width * 0.6,
              activeBgColor: Colors.green,
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.white24,
              inactiveFgColor: Colors.green,
              initialLabelIndex: 0,
              labels: ['Recent', 'All', 'Unverified'],
              onToggle: (index) {
                print('switched to: $index');
              },
            ),
          ),
        ),

        FutureBuilder(
          future: _receiptsList,
          builder: (context,snapshot){

           

            if(snapshot.hasData){
               _imageTextController.receiptList.assignAll(snapshot.data);
              return ListView.builder(
              shrinkWrap:true,
              itemCount: snapshot.data.length,
              itemBuilder: (context,int i){

                return receipt_short(snapshot.data[i]);


              })
              ;
            }else{
            
            return Center(
              child: Text("No Receipt found !!! ",style: TextStyle(color: Colors.white),),
            );
            }

         
        })







      ],
    ));
  }
}
