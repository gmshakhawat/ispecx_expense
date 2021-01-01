import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ispecx_expense/src/controllers/image_text_controller.dart';
import 'package:ispecx_expense/src/data/category_data.dart';
import 'package:ispecx_expense/src/models/receipts_model.dart';
import 'package:ispecx_expense/src/pages/expense_edit.dart';
import 'package:ispecx_expense/src/widgets/expense_details.dart';

Widget receipt_short(ReceiptsModel rc)
{ 

  ImageTextController imageTextController=Get.find();
//rc.category.color==null?Colors.red:rc.category.color
  return GestureDetector(
    child: Container(
      height: 90,
      decoration: BoxDecoration(
    border: Border(
           
            bottom: BorderSide(width: 3.0, color: Colors.grey.shade900),
          ),
  ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 10,
            color:categoryDataList[rc.colorIndex].color==null?Colors.red:categoryDataList[rc.colorIndex].color,
          ),
          SizedBox(width: 5,),

          Icon(Icons.add_circle_outline,color: Colors.white,),

          Container(
            //color: Colors.green,
            width: Get.width*0.90,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
              
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SafeArea(
                        child: Container(
                          width: Get.width*0.6,
                          child: Text(rc.marcent,style: TextStyle(color: Colors.white,fontSize: 20),)),
                      ),
                      Text("Receipt date : "+rc.date,style: TextStyle(color: Colors.white),),
                      Text(rc.account,style: TextStyle(color: Colors.white),),
                    ],
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("USD "+rc.total.toString(),style: TextStyle(color: Colors.red,fontSize: 16),),
                      Icon(Icons.mode_edit,color: Colors.white,)
                    ],
                  ),
                ],
              ),
            ),
          ),
           

          
          
        ],
      ),
    ),
    onTap: (){

          imageTextController.lastReceipt.value=rc;
          Get.to(ExpenseEdit());
      
    },
  );



}