import 'package:flutter/material.dart';
import 'package:ispecx_expense/src/pages/dashboard_page.dart';
import 'package:ispecx_expense/src/pages/receipts_page.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String _title="Receipts";
  bool isCal=false;

  DashBoard dashBoard;
  Receipts receipts;

  var _page;

  @override
  void initState() {
    // TODO: implement initState
    
    dashBoard=DashBoard();
    receipts=Receipts();

    _page=receipts;




    
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(_title),
        backgroundColor: Colors.grey.shade900,
      ),
      body: _page,
      floatingActionButton: new FloatingActionButton(
      child: new Icon(Icons.camera_alt,size: 35,),
      backgroundColor: Colors.green,
      onPressed: (){}
    ),
  


      drawer: Drawer(
        
        child: ListView(
          children: [

          Container(
            color: Colors.grey.shade900,
            height: 80,
            child: DrawerHeader(
                child: Text('Ispecx Expense',style: TextStyle(fontSize: 23,color: Colors.white),),
                
              ),
          ),
            ListTile(
              title: Text('Receipts',style: TextStyle(fontSize: 18,color: Colors.white),),
              onTap: () {
                
                setState(() {
                  _title="Receipts";
                   _page=receipts;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Dashboard',style: TextStyle(fontSize: 18,color: Colors.white),),
              
              onTap: () {
                
                setState(() {
                  _title="Dashboard";
                   _page=dashBoard;
                });
                Navigator.pop(context);
              },
            ),


          ],
        ),
      ),
      
    );
  }
}