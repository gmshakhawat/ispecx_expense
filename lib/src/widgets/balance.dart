import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ispecx_expense/src/data/month.dart';
import 'package:ispecx_expense/src/models/month_model.dart';
import 'package:ispecx_expense/src/models/receipts_model.dart';

Widget balance(List<double> expence){
  return Expanded(
    child: GridView.count(
      crossAxisCount: 3,
            childAspectRatio: 0.75,
            padding: const EdgeInsets.all(4.0),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            children: <int>[1,2,3,4,5,6,7,8,9,10,11,12
            ].map((int e){

              return _card(MonthModel(color: colors[e-1],name: months[e-1],expense: expence[e].toString()));
              


            }).toList(),
    
    ),
  );


}



Widget _card(MonthModel mm){

  return Container(
    height: 120,
    width: 30,
    color: mm.color,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("- ",style: TextStyle(fontSize: 35),),Text(mm.expense.toString())],),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(mm.name),
            )
          


          ],
        ),
  );


}


