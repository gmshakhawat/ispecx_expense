import 'package:http/http.dart' as http;
import 'package:ispecx_expense/src/models/test_rec_model.dart';

class TextRequeustService {
  //TextRequeustService();

  static String API_KEY = "";
//  String downloadUrl = "https://www.ustraveldocs.com/bd/Bank%20Receipt.jpg";

   Future<TextRecModel> request(image) async {
    print(image);

    String body = """{
  'requests': [
    {
      "image":{
        "content":"$image"
      },

      'features': [
        {
          'type': 'DOCUMENT_TEXT_DETECTION'
        }
      ]
    }
  ]
}""";

    http.Response res = await http.post(
        "https://us-vision.googleapis.com/v1/images:annotate?key=$API_KEY",
        body: body);

    if (res.body.isNotEmpty) {
      print("${res.body}");
      //TextRecModel textRecModel=TextRecModel();


     // print(textRecModelFromJson(res.body));

      return textRecModelFromJson(res.body);
    } 
  }
}
