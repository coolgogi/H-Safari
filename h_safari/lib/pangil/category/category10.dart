import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_safari/pangil/Alarm.dart';
import 'package:h_safari/pangil/MySearch.dart';


class category10 extends StatefulWidget {
  @override
  _category10State createState() => _category10State();
}

class _category10State extends State<category10> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('한동나눔')),
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

