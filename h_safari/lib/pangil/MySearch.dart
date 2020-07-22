import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class mysearch extends StatefulWidget {
  @override
  _mysearchState createState() => _mysearchState();
}

class _mysearchState extends State<mysearch> {

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 1,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: TextField(
            style: TextStyle(fontSize: 16, color: Colors.white),
            textAlign: TextAlign.start,
            decoration: InputDecoration(hintText: '검색어를 입력해주세요'),
            onChanged: (String str) {},
            autofocus: true,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
