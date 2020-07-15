import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_safari/pangil/Alarm.dart';
import 'package:h_safari/pangil/MySearch.dart';


class category11 extends StatefulWidget {
  @override
  _category11State createState() => _category11State();
}

class _category11State extends State<category11> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('양도구해요/해요')),
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

