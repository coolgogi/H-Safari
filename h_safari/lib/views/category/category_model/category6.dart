import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_safari/views/main/search.dart';


class category6 extends StatefulWidget {
  @override
  _category6State createState() => _category6State();
}

class _category6State extends State<category6> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('뷰티/잡화')),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
            },
          ),
          ]

      ),
    );
  }
}

