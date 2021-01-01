import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ispecx_expense/src/models/receipts_model.dart';

Widget expense_details(ReceiptsModel rc){
  return Column(
    children: [

      Row(
        children: [
         _row2(Icons.home, "Marcent"),
          Text(rc.marcent,style: TextStyle(color: Colors.white),)


        ],
      )





    ],
  );


}

Widget _row2(IconData ic, String title){

  return Row(
        children: [
          Icon( ic,color: Colors.green,),
          Text(title,style: TextStyle(color: Colors.white),)


        ],
      );


}


