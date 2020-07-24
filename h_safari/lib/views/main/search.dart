import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

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
