import 'package:get/get.dart';
import 'package:ispecx_expense/src/models/receipts_model.dart';
import 'package:ispecx_expense/src/models/test_rec_model.dart' as textRec;
import 'package:ispecx_expense/src/others/text_clasification.dart';

import 'package:ispecx_expense/src/services/text_request_service.dart';

class ImageTextController extends GetxController {
  var base64Image = ''.obs;


  final lastReceipt=ReceiptsModel(marcent: "",date: "",total: 0,tags: "").obs;
  var receiptList= List<ReceiptsModel>().obs;
  
  final isImage = false.obs;

  var states=0.obs;


  void setStatus(bool st){

    isImage.value=st;
  }

  bool getStatus(){
    return isImage.value;
  }
  
  List<ReceiptsModel> getReceiptList(){
    return receiptList;
  }



  void convertBase64(img) async {

    
    base64Image.value = img;

    if (!base64Image.isNull) {
      textRec.TextRecModel data = await TextRequeustService().request(img);

      if (data != null) {
        TextClasification()
            .clasification(data.responses[0].textAnnotations[0].description);
      }
    }

    print("Image_______________");
  }
}
