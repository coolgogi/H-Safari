import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_safari/pangil/Alarm.dart';
import 'package:h_safari/pangil/MySearch.dart';


class category4 extends StatefulWidget {
  @override
  _category4State createState() => _category4State();
}

class _category4State extends State<category4> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('뷰티/미용')),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => mysearch()));
            },
          ),
          ]

      ),
    );
  }
}

