import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Receipts extends StatefulWidget {
  @override
  _ReceiptsState createState() => _ReceiptsState();
}

class _ReceiptsState extends State<Receipts> {
  Color _rcolor, _acolor, _ucolor;
  Color _rtcolor, _atcolor, _utcolor;
  double _rsize, _asize, _usize;

  @override
  void initState() {
    // TODO: implement initState

    _rcolor = Colors.green;
    _acolor = Colors.white24;
    _ucolor = Colors.white24;

    _rtcolor = Colors.white;
    _atcolor = Colors.green;
    _utcolor = Colors.green;
    _rsize = 10.0;
    _asize = 0.0;
    _usize = 0.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                shape: RoundedRectangleBorder( 
                    borderRadius: BorderRadius.circular(_rsize)),
                clipBehavior: Clip.antiAlias,
                color: _rcolor,
                child: Text(
                  "Recent",
                  style: TextStyle(fontSize: 18, color: _rtcolor),
                ),
                onPressed: () {
                  setState(() {
                    _rcolor = Colors.green;
                    _acolor = Colors.white24;
                    _ucolor = Colors.white24;

                    _rtcolor = Colors.white;
                    _atcolor = Colors.green;
                    _utcolor = Colors.green;
                    _rsize = 10.0;
                    _asize = 0.0;
                    _usize = 0.0;
                  });
                },
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(_asize)),
                clipBehavior: Clip.antiAlias,
                color: _acolor,
                child: Text(
                  "All",
                  style: TextStyle(fontSize: 18, color: _atcolor),
                ),
                onPressed: () {
                  setState(() {
                    _rcolor = Colors.white24;
                    _acolor = Colors.green;
                    _ucolor = Colors.white24;

                    _rtcolor = Colors.green;
                    _atcolor = Colors.white;
                    _utcolor = Colors.green;
                    _rsize = 0.0;
                    _asize = 10.0;
                    _usize = 0.0;
                  });
                },
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(_usize)),
                clipBehavior: Clip.antiAlias,
                color: _ucolor,
                child: Text(
                  "Unverified",
                  style: TextStyle(fontSize: 18, color: _utcolor),
                ),
                onPressed: () {
                  setState(() {
                    _rcolor = Colors.white24;
                    _acolor = Colors.white24;
                    _ucolor = Colors.green;

                    _rtcolor = Colors.green;
                    _atcolor = Colors.green;
                    _utcolor = Colors.white;
                    _rsize = 0.0;
                    _asize = 0.0;
                    _usize = 10.0;
                  });
                },
              )
            ],
          ),
        )
      ],
    ));
  }
}
