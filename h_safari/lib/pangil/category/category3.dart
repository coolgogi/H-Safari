import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_safari/pangil/MySearch.dart';


class category3 extends StatefulWidget {
  @override
  _category3State createState() => _category3State();
}

class _category3State extends State<category3> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('음식')),
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
