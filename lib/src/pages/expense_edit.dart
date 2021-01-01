import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:get/get.dart';
import 'package:ispecx_expense/src/controllers/image_text_controller.dart';
import 'package:ispecx_expense/src/helper/receipt_helper.dart';
import 'package:ispecx_expense/src/pages/home_page.dart';
import 'package:ispecx_expense/src/screens/category_chose.dart';

class ExpenseEdit extends StatefulWidget {
  @override
  _ExpenseEditState createState() => _ExpenseEditState();
}

class _ExpenseEditState extends State<ExpenseEdit> {
  ImageTextController imageTextController = Get.find();

  TextEditingController marcentText = TextEditingController();

  TextEditingController totalText = TextEditingController();

  TextEditingController noteText = TextEditingController();

  TextEditingController accountText = TextEditingController();

  ReceiptHelper _receiptHelper = ReceiptHelper();
  @override
  void initState() {
    // TODO: implement initState

    _receiptHelper.initializeDatabase().then((value) {
      print("==Initicalized==");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.white),
          title: Text(
            "Expense",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.grey.shade800,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ),
              onPressed: () {
                if (imageTextController.lastReceipt.value.marcent.isNotEmpty) {
                  if (imageTextController.lastReceipt.value.date.isNotEmpty) {
                    if (imageTextController
                        .lastReceipt.value.category.isNotEmpty) {
                      if (imageTextController.lastReceipt.value.id.isNull) {
                        _receiptHelper.insertReceipt(
                            imageTextController.lastReceipt.value);
                      } else {
                        _receiptHelper
                            .update(imageTextController.lastReceipt.value);

                          //   Get.back();
                      }

                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));

                     




                    } else {
                      print("No no category");
                    }
                  } else {
                    print("No date");
                  }
                } else {
                  print("No marcent");
                }
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Obx(
            () => Container(
              color: Colors.white24,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _row2(Icons.account_balance, "Marcent"),
                          Text(
                            "  " +
                                imageTextController.lastReceipt.value.marcent,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        ],
                      ),
                      onTap: () {
                        marcentText.text =
                            imageTextController.lastReceipt.value.marcent;

                        _inDialog(context, marcentDialog(context));
                      },
                    ),
                  ),
                  new Divider(
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _row2(Icons.today_rounded, "Date"),
                          Text(
                            imageTextController.lastReceipt.value.date,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        ],
                      ),
                      onTap: () {
                        _selectDate(context);
                      },
                    ),
                  ),
                  new Divider(
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _row2(Icons.equalizer_outlined, "Total"),
                          Row(
                            children: [
                              Text(
                                imageTextController.lastReceipt.value.total
                                    .toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Text(
                                  " USD ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      backgroundColor: Colors.green),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: () {
                        totalText.text = imageTextController
                            .lastReceipt.value.total
                            .toString();

                        _inDialog(context, totalDialog(context));
                      },
                    ),
                  ),
                  new Divider(
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _row2(Icons.category_rounded, "Category"),
                          Container(
                            child: Text(
                              "  " +
                                  imageTextController
                                      .lastReceipt.value.category,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Get.to(CategoryChose());
                      },
                    ),
                  ),
                  new Divider(
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _row2(Icons.donut_large, "Account"),
                          Text(
                            imageTextController.lastReceipt.value.account,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        ],
                      ),
                      onTap: () {
                        accountText.text =
                            imageTextController.lastReceipt.value.account;

                        _inDialog(context, accountDialog(context));
                      },
                    ),
                  ),
                  new Divider(
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _row2(Icons.label, "Tags"),
                          Text(
                            imageTextController.lastReceipt.value.tags,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        ],
                      ),
                      onTap: () {
                        List<String> tagList = imageTextController
                            .lastReceipt.value.tags
                            .split(",");

                        List<Language> list = [];

                        for (int i = 1; i < tagList.length; i++) {
                          list.add(Language(name: tagList[i], position: i));
                        }
                        _inDialog(context, _tagSelection(list));
                      },
                    ),
                  ),
                  new Divider(
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _row2(Icons.list_alt, "Is this a bill "),
                          FlutterSwitch(
                            width: 70.0,
                            height: 40.0,
                            valueFontSize: 12.0,
                            toggleSize: 25.0,
                            activeColor: Colors.green,
                            value:
                                imageTextController.lastReceipt.value.isBill ==
                                        0
                                    ? false
                                    : true,
                            onToggle: (val) {
                              imageTextController.lastReceipt.value.isBill =
                                  val ? 1 : 0;

                              imageTextController.lastReceipt.refresh();
                            },
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  new Divider(
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          noteWidget(),
                          Text(
                            ": " + imageTextController.lastReceipt.value.notes,
                            style:
                                TextStyle(color: Colors.white24, fontSize: 20),
                          )
                        ],
                      ),
                      onTap: () {
                        noteText.text =
                            imageTextController.lastReceipt.value.notes;

                        _inDialog(context, noteDialog(context));
                      },
                    ),
                  ),
                  new Divider(
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _row2(IconData ic, String title) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            ic,
            color: Colors.green,
            size: 40,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        SizedBox(
          width: 5,
        ),
      ],
    );
  }

  Widget noteWidget() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.note_add,
            color: Colors.green,
            size: 40,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          "Notes",
          style: TextStyle(color: Colors.white24, fontSize: 20),
        ),
        SizedBox(
          width: 5,
        ),
      ],
    );
  }

  DateTime selectedDate = DateTime.now();

  String startDate0 = 'Start Date';

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;

      print(selectedDate);

      imageTextController.lastReceipt.value.date =
          selectedDate.month.toString()+"/"+selectedDate.day.toString()+"/"+selectedDate.year.toString();
      imageTextController.lastReceipt.refresh();
    }
  }

  _inDialog(BuildContext context, Widget item) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              contentPadding: EdgeInsets.only(top: 10.0),
              content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: Get.width * 0.9,
                  height: Get.height * 0.30,
                  child: SingleChildScrollView(child: item),
                );
              }));
        });
  }

  Widget noteDialog(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "Notes",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Divider(
          color: Colors.grey,
          height: 4.0,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                    width: 2, color: Colors.grey, style: BorderStyle.solid)),
            child: TextFormField(
              controller: noteText,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                hintText: "Notes",
              ),
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: RaisedButton(
            color: Colors.green,
            onPressed: () {
              if (noteText.text.isNotEmpty) {
                imageTextController.lastReceipt.value.notes =
                    noteText.text.toString();
                imageTextController.lastReceipt.refresh();
                Navigator.of(context, rootNavigator: true).pop('dialog');

                marcentText.clear();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Update",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget marcentDialog(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "Marcent",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Divider(
          color: Colors.grey,
          height: 4.0,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                    width: 2, color: Colors.grey, style: BorderStyle.solid)),
            child: TextFormField(
              controller: marcentText,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                hintText: "Marcent",
              ),
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: RaisedButton(
            color: Colors.green,
            onPressed: () {
              if (marcentText.text.isNotEmpty) {
                imageTextController.lastReceipt.value.marcent =
                    marcentText.text.toString();
                imageTextController.lastReceipt.refresh();
                Navigator.of(context, rootNavigator: true).pop('dialog');

                accountText.clear();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Update",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget accountDialog(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "Account Type",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Divider(
          color: Colors.grey,
          height: 4.0,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                    width: 2, color: Colors.grey, style: BorderStyle.solid)),
            child: TextFormField(
              controller: accountText,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                hintText: "Account Type",
              ),
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: RaisedButton(
            color: Colors.green,
            onPressed: () {
              if (accountText.text.isNotEmpty) {
                imageTextController.lastReceipt.value.account =
                    accountText.text.toString().toUpperCase();
                imageTextController.lastReceipt.refresh();
                Navigator.of(context, rootNavigator: true).pop('dialog');

                accountText.clear();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Update",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget totalDialog(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "Total",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Divider(
          color: Colors.grey,
          height: 4.0,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                    width: 2, color: Colors.grey, style: BorderStyle.solid)),
            child: TextFormField(
              controller: totalText,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                hintText: "total",
              ),
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: RaisedButton(
            color: Colors.green,
            onPressed: () {
              if (totalText.text.isNotEmpty) {
                imageTextController.lastReceipt.value.total =
                    double.parse(totalText.text.toString());

                imageTextController.lastReceipt.refresh();
                Navigator.of(context, rootNavigator: true).pop('dialog');

                totalText.clear();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Update",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _tagSelection(List<Language> list) {
    List<Language> _selectedLanguages = list;
    return FlutterTagging<Language>(
        initialItems: _selectedLanguages,
        textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.green.withAlpha(30),
            hintText: 'Search Tags',
            labelText: 'Write Tags',
          ),
        ),
        findSuggestions: LanguageService.getLanguages,
        additionCallback: (value) {
          return Language(
            name: value,
            position: 0,
          );
        },
        onAdded: (language) {
          // api calls here, triggered when add to tag button is pressed
          imageTextController.lastReceipt.value.tags += "," + language.name;
          return language;
        },
        configureSuggestion: (lang) {
          return SuggestionConfiguration(
            title: Text(
              lang.name,
              style: TextStyle(color: Colors.white),
            ),
            // subtitle: Text("lang.position.toString()"),
            additionWidget: Chip(
              avatar: Icon(
                Icons.add_circle,
                color: Colors.white,
              ),
              label: Text('Add New Tag'),
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w300,
              ),
              backgroundColor: Colors.green,
            ),
          );
        },
        configureChip: (lang) {
          return ChipConfiguration(
            label: Text(lang.name),
            backgroundColor: Colors.green,
            labelStyle: TextStyle(color: Colors.white),
            deleteIconColor: Colors.white,
          );
        },
        onChanged: () {
          print("Tap");
          String newTags = "";
          for (int i = 0; i < _selectedLanguages.length; i++) {
            newTags += "," + _selectedLanguages[i].name;
          }

          imageTextController.lastReceipt.value.tags = newTags;
          imageTextController.lastReceipt.refresh();
        });
  }
}

class LanguageService {
  /// Mocks fetching language from network API with delay of 500ms.
  static Future<List<Language>> getLanguages(String query) async {
    await Future.delayed(Duration(milliseconds: 500), null);
    return <Language>[
      Language(name: 'Savings', position: 1),
      Language(name: 'Cash', position: 2),
      Language(name: 'Deposit', position: 3),
      Language(name: 'Borrowed', position: 4),
      Language(name: 'Payment', position: 5),
      Language(name: 'Bank', position: 6),
      Language(name: 'Card', position: 6),
      Language(name: 'VISA', position: 6),
    ]
        .where((lang) => lang.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

class Language extends Taggable {
  ///
  final String name;

  ///
  final int position;

  /// Creates Language
  Language({
    this.name,
    this.position,
  });

  @override
  List<Object> get props => [name];

  /// Converts the class to json string.
  String toJson() => '''  {
    "name": $name,\n
    "position": $position\n
  }''';
}
