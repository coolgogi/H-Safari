import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_safari/views/main/search.dart';

class categoryView extends StatefulWidget {
  final String select;
  categoryView({this.select});

  @override
  _categoryViewState createState() => _categoryViewState(select : select);
}

class _categoryViewState extends State<categoryView> {
  final String select;
  _categoryViewState({this.select});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('$select'),
          ),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
                }
            ),
          ],
//          bottom: TabBar(
//            labelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
//            tabs: <Widget>[
//              Tab(text: '전체보기',),
//              Tab(text: '반팔 티셔츠'),
//              Tab(text: '맨투맨/후드티'),
//              Tab(text: '점퍼/야상/패딩'),
//              Tab(text: '맨투맨/후드티'),
//              Tab(text: '점퍼/야상/패딩'),
//            ],
//            isScrollable: true,),


        ),

      ),
    );
  }
}
