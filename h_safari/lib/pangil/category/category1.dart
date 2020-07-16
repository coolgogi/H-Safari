import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_safari/pangil/MySearch.dart';


class category1 extends StatefulWidget {
  @override
  _category1State createState() => _category1State();
}

class _category1State extends State<category1> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('의류')),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => mysearch()));
                }
              ),
            ],
          bottom: TabBar(
            labelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              tabs: <Widget>[
                Tab(text: '전체보기',),
                Tab(text: '반팔 티셔츠'),
                Tab(text: '맨투맨/후드티'),
                Tab(text: '점퍼/야상/패딩'),
                Tab(text: '맨투맨/후드티'),
                Tab(text: '점퍼/야상/패딩'),
              ],
            isScrollable: true,),


        ),

      ),
    );
  }
}

