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
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: TextField(
            style: TextStyle(fontSize: 16, color: Colors.white),
            textAlign: TextAlign.start,
            decoration: InputDecoration(hintText: '검색어를 입력해주세요'),
            onChanged: (String str) {},
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
          bottom: TabBar(
            unselectedLabelColor: Colors.white,
            indicatorPadding: EdgeInsets.only(left: 30, right: 30),
            indicator: ShapeDecoration(
                color: Colors.lightBlueAccent,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
            labelStyle: TextStyle(fontSize: 15, height: 1),
            tabs: <Widget>[
              Tab(text: '최근검색어'),
              Tab(text: '인기검색어'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[

                    //from SH
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[


                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
