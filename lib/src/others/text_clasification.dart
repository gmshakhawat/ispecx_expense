import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:ispecx_expense/src/controllers/image_text_controller.dart';
import 'package:ispecx_expense/src/data/category_data.dart';
import 'package:ispecx_expense/src/models/category_model.dart';
import 'package:ispecx_expense/src/models/receipts_model.dart';

class TextClasification{

   String marcent, date, category, account, tags, returns, notes;
   double total;
   bool isBisiness, isBill;

   ImageTextController receptController=Get.put(ImageTextController());

  void clasification(String data){

    List<String> dataList=data.split("\n");


 

    for(int i=0; i<dataList.length;i++){
      //print("value__");

      print(dataList[i]);

      if(i==0){
        if(dataList[i].toUpperCase().startsWith("WELCOME TO ")|| dataList[i].toUpperCase().startsWith("MELCOME TO ")){
          var names=dataList[i].split("Welcome to");
          marcent=names[0];
        }
        else{
          marcent=dataList[i];
        }
      }

      if(dataList[i].toUpperCase().startsWith("VISA")){
        account="VISA";
      }

       if(dataList[i].toUpperCase().startsWith("VISA CREDIT")){
        account="VISA CREDIT";
      }
       if(dataList[i].toUpperCase().startsWith("MASTER")){
        account="MASTER";
      }

        if(dataList[i].toUpperCase().startsWith("CREDIT")){
        account="CREDIT";
      }


        if(dataList[i].startsWith("\$") ){

            var cost=dataList[i].replaceFirst(new RegExp(r'[^\w\s]+'),'');
            print("COs");
            print(cost);

            total=double.parse(cost);

        }


        if(dataList[i].contains("/") ){

            

            date=dataList[i].split(" ")[0];
        }

     

      // if(dataList[i]=="Not Valid for Refund"){
      //   is
      // }



    }

    if(total!=0){

    if(account.isEmpty){
      account="CASH";
    }

    print("Marc-"+marcent);
    print("total-"+total.toString());
    print("date-"+date.toString());
    print("ac-"+account);


    ReceiptsModel receiptsModel=ReceiptsModel(isBill: 1 ,marcent: marcent,total: total,date: date,account: account,category: categoryDataList[0].name,colorIndex: 0,notes: "",tags: "",);



    receptController.lastReceipt.value=receiptsModel;

    receptController.isImage.value=true;

    


    }

  }





}