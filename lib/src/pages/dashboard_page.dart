import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ispecx_expense/src/controllers/image_text_controller.dart';
import 'package:ispecx_expense/src/data/month.dart';
import 'package:ispecx_expense/src/models/month_model.dart';
import 'package:ispecx_expense/src/models/receipts_model.dart';
import 'package:ispecx_expense/src/models/summary_model.dart';
import 'package:ispecx_expense/src/widgets/balance.dart';
import 'package:ispecx_expense/src/widgets/summary.dart';
import 'package:toggle_switch/toggle_switch.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<Widget> _page;

  ImageTextController _imageTextController = Get.find();

  Widget _summary, _category, _balance, _account;

  @override
  void initState() {
    // TODO: implement initState

    _balance = balance(_getMonthlyCost(_imageTextController.getReceiptList()));
    _summary = summary(_getSummary(_imageTextController.getReceiptList()));
    _category = CircularProgressIndicator();
    _account = CircularProgressIndicator();

    _page = [_summary, _category, _account, _balance];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              labels: ['Summary', 'Category', 'Account', 'Balance'],
              onToggle: (index) {
                print('switched to: $index');
                _imageTextController.states.value = index;
              },
            ),
          ),
        ),

        Obx(
          () => _page[_imageTextController.states.value],
        ),
        // summary(),
      ],
    );
  }

  List<double> _getMonthlyCost(List<ReceiptsModel> receiptList) {
    List<MonthModel> _monthlyList = [];

    List<double> _exp = [
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0
    ];

    DateTime time = DateTime.now();

    receiptList.forEach((element) {
      int month, year;

      if (element.date.isNotEmpty) {
        month = int.parse(element.date.split("/")[0]);
        year = int.parse(element.date.split("/")[2]);

        if (year == time.year) {
          _exp[month] = _exp[month] + element.total;
        }
      }
    });

    return _exp;
  }

  SummaryModel _getSummary(List<ReceiptsModel> receiptList) {
    List<MonthModel> _monthlyList = [];

    double mt = 0.0, wt = 0.0, dt = 0.0, t = 0.0, yt = 0.0;

    DateTime time = DateTime.now();
    String md, dd, yd, td, wd;

    SummaryModel sm;
    int month, year, day, ws, we, bill = 0, receipt = 0;

   
   // we = ws+7;
   DateTime start=time.subtract(Duration(days: time.weekday));

    DateTime end=time.add(Duration(days: 7-time.weekday));
    ws =start.day;
    we=end.day;
  


    String ms=months[start.month-1].substring(0,3);
    String me=months[end.month-1].substring(0,3);

    print(time.weekday);

    wd="$ms $ws - $me $we";
    md=months[time.month-1];
    td="${md.substring(0,3)} ${time.day}, ${time.year}";
    
    yd=time.year.toString();

    // wd="$m $ws - $";
    // print('Start of week: ${getDate(date.subtract(Duration(days: date.weekday - 1)))}');
    // print('End of week: ${getDate(date.add(Duration(days: DateTime.daysPerWeek - date.weekday)))}');

    print(ms);

    receiptList.forEach((element) {
      if (element.date.isNotEmpty) {
        month = int.parse(element.date.split("/")[0]);
        year = int.parse(element.date.split("/")[2]);
        day = int.parse(element.date.split("/")[1]);

        DateTime eDate=DateTime(year,month,day);
     
        

        if (element.isBill == 0) {
          receipt++;
        } else {
          bill++;
        }

        t += element.total;

       

        if (year == time.year) {
          yt += element.total;
          if (month == time.month) {
            mt += element.total;

            if((eDate.compareTo(start)==0 )|| (eDate.compareTo(start)>0 && eDate.compareTo(end)<0 ) )
        {
              wt += element.total;
              if (day == time.day) {
                dt += element.total;
                 print(day.toString() +"== "+ time.day.toString()+"="+dt.toString());
              }
            }
          }
        }




      }
    });

    sm = SummaryModel(
        expense: t,
        bill: bill,
        month: mt,
        year: yt,
        today: dt,
        week: wt,
        receipt: receipt,
        monthDate: md,
        todayDate: td,
        weekDate: wd,
        yearDate: yd,
        total: t);

    return sm;
  }
}
