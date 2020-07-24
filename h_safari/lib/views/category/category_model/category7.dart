import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_safari/views/main/search.dart';


class category7 extends StatefulWidget {
  @override
  _category7State createState() => _category7State();
}

class _category7State extends State<category7> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('양도')),
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

