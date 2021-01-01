import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ispecx_expense/src/controllers/image_text_controller.dart';
import 'package:ispecx_expense/src/data/category_data.dart';
import 'package:ispecx_expense/src/models/category_model.dart';

class CategoryChose extends StatefulWidget {
  @override
  _CategoryChoseState createState() => _CategoryChoseState();
}

class _CategoryChoseState extends State<CategoryChose> {
  ImageTextController imageTextController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // centerTitle: true,

          leading: BackButton(color: Colors.white),
          title: Text(
            "Expense  ->  Choose Category",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.grey.shade800,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(),
         
        ),
        body: ListView.builder(
            itemCount: categoryDataList.length,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              List<String> subList = categoryDataList[i].name.split("-");
              return Card(
                color: Colors.white24,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8),
                  child: Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          color: Colors.transparent,
                          child: Row(children: [
                            Container(
                              height: 30,
                              width: 30,
                              color: categoryDataList[i].color,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              subList[0],
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ]),
                        ),
                        onTap: () {
                          imageTextController.lastReceipt.value.category =
                              categoryDataList[i].name;
                              imageTextController.lastReceipt.value.colorIndex =i;

                              imageTextController.lastReceipt.refresh();

                              Get.back();
                        },
                      ),
                      new Divider(
                        color: Colors.grey,
                      ),
                      for (int j = 1; j < subList.length; j++)
                        Column(
                          children: [
                            myCategory(subList[j],i),
                            new Divider(
                              color: Colors.grey,
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              );
            }));
  }

  Widget myCategory(String cat,int clr) {
    return GestureDetector(
      child: Container(
        color:Colors.transparent,
        child: Row(children: [
          Container(
            height: 30,
            width: 30,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            cat,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ]),
      ),
      onTap: () {
        imageTextController.lastReceipt.value.category =cat;
        imageTextController.lastReceipt.value.colorIndex=clr;
           imageTextController.lastReceipt.refresh();
        Get.back();
      },
    );
  }
}
