import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ispecx_expense/src/models/month_model.dart';
import 'package:ispecx_expense/src/models/summary_model.dart';


Widget summary(SummaryModel expence) {
  return SingleChildScrollView(
    child: Column(
      children: [
        card1(Icons.grain, "Expense", expence.total.toString()),
        Divider(
          color: Colors.grey,
          height: 3,
        ),
        card1(Icons.list_alt, "Bills", expence.bill.toString()),
        Divider(
          color: Colors.grey,
          height: 3,
        ),
        card1(Icons.format_list_numbered, "Receipts", expence.receipt.toString()),
         Divider(
          color: Colors.grey,
          height: 3,
        ),
        SizedBox(
          height: 90,
        ),


        card2(Icons.calendar_today, "Today",expence.todayDate, expence.today.toString()),
         Divider(
          color: Colors.grey,
          height: 3,
        ),

        card2(Icons.date_range, "This Week",expence.weekDate, expence.week.toString()),
         Divider(
          color: Colors.grey,
          height: 3,
        ),

        card2(Icons.calendar_view_day_rounded, "This Month",expence.monthDate, expence.month.toString()),
         Divider(
          color: Colors.grey,
          height: 3,
        ),

        card2(Icons.data_usage, "This Year",expence.yearDate, expence.year.toString()),
         Divider(
          color: Colors.grey,
          height: 3,
        ),



      ],
    ),
  );
}

Widget card1(IconData ic, String title, String value) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Row(
          children: [
            Icon(ic,size: 50,color: Colors.green,),
            SizedBox(width: 10,),
            Text(title,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
          ],
        ),

        Text(value,style: TextStyle(color: Colors.white,fontSize: 20),),
        
        




      ],
    ),
  );
}


Widget card2(IconData ic, String title,String subTitle , String value) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Row(
          children: [
            Icon(ic,size: 50,color: Colors.green,),
            SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                Text(subTitle,style: TextStyle(color: Colors.white,fontSize: 17),),
              ],
            ),
          ],
        ),

        Text(value,style: TextStyle(color: Colors.white,fontSize: 20),),
        
        




      ],
    ),
  );
}




