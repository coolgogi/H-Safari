import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:h_safari/pangil/MySearch.dart';


class category2 extends StatefulWidget {
  @override
  _category2State createState() => _category2State();
}

class _category2State extends State<category2> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('남성의류')),
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

