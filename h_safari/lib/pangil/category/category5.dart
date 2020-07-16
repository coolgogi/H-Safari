import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_safari/pangil/MySearch.dart';


class category5 extends StatefulWidget {
  @override
  _category5State createState() => _category5State();
}

class _category5State extends State<category5> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('스포츠/레저')),
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

